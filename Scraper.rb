require "open-uri"
require "json"
require "nokogiri"

# urla = "https://fr.wannasurf.com/spot/Europe/France/Brittany_South/index.html"
# html_filea = URI.open(urla).read
# html_doca = Nokogiri::HTML(html_filea)

# urlb = "https://fr.wannasurf.com/spot/Europe/France/Brittany_North/index.html"
# html_fileb = URI.open(urlb).read
# html_docb = Nokogiri::HTML(html_fileb)

# spots_data = []
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
# end
# puts spots_data
# dire = Nokogiri::HTML(URI.open("https://fr.wannasurf.com#{list_href[0]}").read)
# p dire.at('span.wanna-item-label:contains("Direction")').next_sibling.text.strip

# url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/rennes/2022-12-02?unitGroup=metric&include=current%2Cdays&key=74L85ARD35G27DPFUZL5SS6GA&contentType=json"
# meteo_serialized = URI.parse(url).read
# meteo = JSON.parse(meteo_serialized)
