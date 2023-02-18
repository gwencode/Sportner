require_relative 'config/environment'
require "open-uri"
require "json"
require "nokogiri"
require 'dotenv'
Dotenv.load
require 'date'

# puts "beginning scraping"

# urla = "https://fr.wannasurf.com/spot/Europe/France/Brittany_South/index.html"
# html_filea = URI.open(urla).read
# html_doca = Nokogiri::HTML(html_filea)

# urlb = "https://fr.wannasurf.com/spot/Europe/France/Brittany_North/index.html"
# html_fileb = URI.open(urlb).read
# html_docb = Nokogiri::HTML(html_fileb)

# spots_data = []
# spots_photos_url = []
# spots_coord = []
# list_href = []
# html_doca.search(".wanna-tabzonespot-item-title").each do |a|
#   list_href << a.attribute("href").value
# end
# html_docb.search(".wanna-tabzonespot-item-title").each do |a|
#   list_href << a.attribute("href").value
# end
# list_href.each do |ref|
#   html = ""
#   begin
#     url = "https://fr.wannasurf.com#{ref}"
#     html = URI.open(url).read
#   rescue
#     next
#   end
#   doc = Nokogiri::HTML(html)
#   spots_data << [{
#     location: doc.search(".wanna-item-title-title a").text.strip,
#     spot_difficulty: doc.at('span.wanna-item-label:contains("Experience")').next_sibling&.text&.strip,
#     wave_type: doc.at('span.wanna-item-label:contains("Type")').next_sibling&.text&.strip,
#     wave_direction: doc.at('span.wanna-item-label:contains("Direction")').next_sibling&.text&.strip,
#     bottom: doc.at('span.wanna-item-label:contains("Fond")').next_sibling&.text&.strip,
#     wave_height_infos: doc.at('span.wanna-item-label:contains("Taille de la houle")').next_sibling&.text&.strip,
#     tide_conditions: doc.at('span.wanna-item-label:contains("Condition de marée")').next_sibling&.text&.strip,
#     danger: doc.at('h5:contains("Dangers")').next_sibling&.text&.strip
#   }]
#   icon_photo_tag = doc.search(".wanna-photovideo-cell-img img")
#   if icon_photo_tag == []
#     photo_url = "https://img.freepik.com/premium-vector/car-woman-surfing-beach-icon_571469-360.jpg?w=2000"
#   elsif icon_photo_tag[0].nil?
#     photo_url = "https://img.freepik.com/premium-vector/car-woman-surfing-beach-icon_571469-360.jpg?w=2000"
#   else
#     # Chercher le lien de redirection de la photo miniature
#     icon_photo_tag_url = doc.search(".wanna-photovideo-cell-img a")
#     # Récupérer et stocker le lien de redirection
#     photo_page_url = "https://fr.wannasurf.com#{icon_photo_tag_url[0].attributes["href"].value}"
#     # Ouvrir le lien avec open uri et Nogogirki
#     photo_page_html = URI.open(photo_page_url).read
#     photo_doc = Nokogiri::HTML(photo_page_html)
#     # Chercher et stocker l'url de la photo
#     photo_sub_url = photo_doc.search(".photo-frame")[0].attributes["src"].value
#     photo_url = "https://fr.wannasurf.com#{photo_sub_url}"
#   end
#   spots_photos_url << photo_url

#   # Scraping des coordonnées
#   lat = doc.at('span.wanna-item-label-gps:contains("Latitude")')&.next_sibling&.text
#   p lat
#   # => " 48° 20.875' N" / ou nil si pas de coordonnées
#   # latitude: 48.6526078,
#   unless lat.nil?
#     lat = lat.chop.chop.chop
#     lat.slice!(0)
#     # => "48° 20.875"
#     lat_DMC = lat.split("° ")
#     # => ["48", "20.875"]
#     deg = lat_DMC.first.to_i
#     lat_sec = lat_DMC.last.to_f
#     # => ["20", "875"]
#     sec = (lat_sec * 60 ).fdiv(3600)
#     lat_DD = deg + sec
#     p lat_DD
#   end

#   lng = doc.at('span.wanna-item-label-gps:contains("Longitude")')&.next_sibling&.text
#   p lng
#   # => " 4° 42.139' W" / ou nil si pas de coordonnées
#   # longitude: -4.3047966>
#   unless lng.nil?
#     lng = lng.chop.chop.chop
#     lng.slice!(0)
#     # => "48° 20.875"
#     lng_DMC = lng.split("° ")
#     # => ["48", "20.875"]
#     deg = lng_DMC.first.to_i
#     lng_sec = lng_DMC.last.to_f
#     # => ["20", "875"]
#     sec = (lng_sec * 60).fdiv(3600)
#     lng_DD = - deg - sec
#     p lng_DD
#   end
#   spots_coord << [lat_DD, lng_DD]
# end
# p spots_data
# p spots_photos_url
# p spots_coord

# dire = Nokogiri::HTML(URI.open("https://fr.wannasurf.com#{list_href[0]}").read)
# p dire.at('span.wanna-item-label:contains("Direction")').next_sibling.text.strip

run_event = Event.first
surf_event = Event.last

puts 'Parsing Weather'
weather_api_key = ENV['WEATHER_API_KEY']
url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/rennes?key=#{weather_api_key}"
meteo_serialized = URI.parse(url).read
meteo = JSON.parse(meteo_serialized)

meteos = []

meteo['days'].each do |day|
  date_string = day['datetime']
  day['hours'].each do |hour|
    time_string = hour['datetime']
    datetime_string = "#{date_string} #{time_string}"
    datetime = DateTime.parse(datetime_string)
    p Meteo.new(event_id: run_event.id,
                report_datetime: datetime)
  end
end



# p run_event
# p run_event.meteos

# #<Meteo:0x00007f22f5444598
#  id: 2,
#  event_id: 2,
#  report_datetime: Fri, 17 Feb 2023 20:28:34.816014000 CET +01:00, # DateTime
#  weather: "Journée partiellement nuageuse",
#  temperature: 15.0,
#  wind_km: 16,
#  wind_kt: 34,
#  wind_direction: 35,
#  wave_height: 3.0,
#  wave_period: 2,
#  wave_direction: 45,
#  sea_temperature: 10,
#  coef: 89,
#  previous_tide_type: "marée-basse",
#  previous_tide_time: Sat, 01 Jan 2000 20:28:32.816029000 CET +01:00,
#  next_tide_type: "marée-haute",
#  next_tide_time: Sat, 01 Jan 2000 20:28:40.816034000 CET +01:00,
#  created_at: Fri, 17 Feb 2023 20:28:34.820156000 CET +01:00,
#  updated_at: Fri, 17 Feb 2023 20:28:34.820156000 CET +01:00>
