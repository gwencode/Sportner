urla = "https://fr.wannasurf.com/spot/Europe/France/Brittany_South/index.html"
html_filea = URI.open(urla).read
html_doca = Nokogiri::HTML(html_filea)

urlb = "https://fr.wannasurf.com/spot/Europe/France/Brittany_North/index.html"
html_fileb = URI.open(urlb).read
html_docb = Nokogiri::HTML(html_fileb)

spots_data = []
spots_photos_urls = []
spots_coord = []
list_href = []
html_doca.search(".wanna-tabzonespot-item-title").each do |a|
  list_href << a.attribute("href").value
end
html_docb.search(".wanna-tabzonespot-item-title").each do |a|
  list_href << a.attribute("href").value
end
list_href.each do |ref|
  html = ""
  begin
    url = "https://fr.wannasurf.com#{ref}"
    html = URI.open(url).read
  rescue
    next
  end
  doc = Nokogiri::HTML(html)
  spots_data << [{
    location: doc.search(".wanna-item-title-title a").text.strip,
    spot_difficulty: doc.at('span.wanna-item-label:contains("Experience")').next_sibling&.text&.strip,
    wave_type: doc.at('span.wanna-item-label:contains("Type")').next_sibling&.text&.strip,
    wave_direction: doc.at('span.wanna-item-label:contains("Direction")').next_sibling&.text&.strip,
    bottom: doc.at('span.wanna-item-label:contains("Fond")').next_sibling&.text&.strip,
    wave_height_infos: doc.at('span.wanna-item-label:contains("Taille de la houle")').next_sibling&.text&.strip,
    tide_conditions: doc.at('span.wanna-item-label:contains("Condition de marée")').next_sibling&.text&.strip,
    danger: doc.at('h5:contains("Dangers")').next_sibling&.text&.strip
  }]
  icon_photo_tag = doc.search(".wanna-photovideo-cell-img img")
  if icon_photo_tag == []
    photos_urls = "https://img.freepik.com/premium-vector/car-woman-surfing-beach-icon_571469-360.jpg?w=2000"
  elsif icon_photo_tag[0].nil?
    photos_urls = "https://img.freepik.com/premium-vector/car-woman-surfing-beach-icon_571469-360.jpg?w=2000"
  else
    # Chercher lien de redirection de toutes les photos
    index_photo = doc.search(".wanna-showall-link")[0].attributes["href"].value
    # Recréer le lien de redirection et ouvrir le document
    index_url = "#{url.delete_suffix('index.html')}#{index_photo}"
    index_html = URI.open(index_url).read
    index_doc = Nokogiri::HTML(index_html)
    # Préparer le stockage de chaque url de photo
    each_photos_sub_urls = []
    # Récupérer chaque élement avec une photo
    photo_tag_urls = index_doc.search(".wanna-sublink")
    photo_tag_urls.each_with_index do |nog_element, index|
      each_photo_url = nog_element.attributes["href"].value.delete_prefix("index.html")
      each_photos_sub_urls << each_photo_url if index.even?
    end

    each_photos_urls = []
    each_photos_sub_urls.each do |sub_url|
      each_photos_urls << "#{index_url}#{sub_url}"
    end

    # Pour chaque lien, ouvrir le lien avec open uri et Nogogirki
    photos_urls = []
    each_photos_urls.each do |photo_page_url|
      photo_page_html = URI.open(photo_page_url).read
      photo_doc = Nokogiri::HTML(photo_page_html)
      # Chercher et stocker l'url de la photo
      photo_sub_url = photo_doc.search(".photo-frame")[0].attributes["src"].value
      photo_url = "https://fr.wannasurf.com#{photo_sub_url}"
      photos_urls << photo_url
    end
  end
  spots_photos_urls << photos_urls

  # Scraping des coordonnées
  lat = doc.at('span.wanna-item-label-gps:contains("Latitude")')&.next_sibling&.text
  # p lat
  # => " 48° 20.875' N" / ou nil si pas de coordonnées
  # latitude: 48.6526078,
  unless lat.nil?
    lat = lat.chop.chop.chop
    lat.slice!(0)
    # => "48° 20.875"
    lat_DMC = lat.split("° ")
    # => ["48", "20.875"]
    deg = lat_DMC.first.to_i
    lat_sec = lat_DMC.last.to_f
    # => ["20", "875"]
    sec = (lat_sec * 60 ).fdiv(3600)
    lat_DD = deg + sec
    # p lat_DD
  end

  lng = doc.at('span.wanna-item-label-gps:contains("Longitude")')&.next_sibling&.text
  # p lng
  # => " 4° 42.139' W" / ou nil si pas de coordonnées
  # longitude: -4.3047966>
  unless lng.nil?
    lng = lng.chop.chop.chop
    lng.slice!(0)
    # => "48° 20.875"
    lng_DMC = lng.split("° ")
    # => ["48", "20.875"]
    deg = lng_DMC.first.to_i
    lng_sec = lng_DMC.last.to_f
    # => ["20", "875"]
    sec = (lng_sec * 60).fdiv(3600)
    lng_DD = - deg - sec
    # p lng_DD
  end
  spots_coord << [lat_DD, lng_DD]
end
puts "Nombre de spots: "
p spots_data.count
puts "Nombre de spots urls: "
p spots_photos_urls.count
puts "Nombre de coordonnées : "
p spots_coord.count

puts "Creating spots"

sleep 1
spots = []
spots_data.each_with_index do |s, index|
  spot = Spot.create!(s.first)
  sleep 1
  # file = File.open("db/fixtures/#{u.last}")
  # user.avatar.attach(io: file, filename: u.last)
  # user.save!
  spot_photos_urls = spots_photos_urls[index]
  if spot_photos_urls.class == Array
    spot_photos_urls.each do |photo_url|
      photo = ""
      begin
        photo = URI.open(photo_url)
      rescue
        next
      end
      spot.photos.attach(io: photo, filename: "#{index}.png", content_type: 'image/jpg')
      spot.save!
    end
  else
    photo = ""
    begin
      photo = URI.open(spot_photos_urls)
    rescue
      next
    end
    spot.photos.attach(io: photo, filename: "#{index}.png", content_type: 'image/jpg')
    spot.save!
  end
  spot_coord = spots_coord[index]
  spot.latitude = spot_coord.first
  spot.longitude = spot_coord.last
  spot.save!
  spots << spot
end
