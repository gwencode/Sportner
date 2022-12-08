require "open-uri"
require "nokogiri"

puts "cleaning DB..."
puts "destroying participations..."
Participation.destroy_all
puts "destroying messages..."
Message.destroy_all
puts "destroying chatrooms..."
Chatroom.destroy_all
puts "destroying reviews..."
Review.destroy_all
puts "destroying favorite_spots..."
FavoriteSpot.destroy_all
puts "destroying itineraries..."
Itinerary.destroy_all
puts "destroying meteos..."
Meteo.destroy_all
puts "destroying events..."
Event.destroy_all
puts "destroying run_details..."
RunDetail.destroy_all
# 2 lignes du dessous à commenter si besoin
# puts "destroying spots..."
# Spot.destroy_all
puts "destroying users..."
User.destroy_all
puts "...cleaning done!"

puts "Create users..."

users = []
user_data = [
  [{first_name: "Clément", last_name: "Cordeiro", email: "clement@me.com", password: "secret", runner: true, surfer: true, run_level: "confirmé", surf_level: "confirmé", address: "9 avenue du président Edouard Heriot, 56000 Vannes", birthday: "26/11/1994"}, "clement.jpeg"],
  [{first_name: "Gwendal", last_name: "Le Bris", email: "gwendal@me.com", password: "secret", runner: true, surfer: true, run_level: "confirmé", surf_level: "débutant", address: "135 rue Lamarck, 75018 Paris", birthday: "12/06/1995"}, "gwendal.jpeg"],
  [{first_name: "Matthieu", last_name: "Nourry", email: "matthieu@me.com", password: "secret", runner: true, surfer: false, run_level: "intermédiaire", address: "labidois, 35490 Romazy", birthday: "29/07/2000"}, "matthieu.jpg"],
  [{first_name: "Olivier", last_name: "Kermoal", email: "olivier@me.com", password: "secret", runner: true, surfer: false, run_level: "intermédiaire", address: "4 avenue de la mare Guesclin, 35230 Saint-Erblon", birthday: "17/09/1990"}, "olivier.jpeg"],
  [{first_name: "Ewena", last_name: "Bressa", email: "ewena@me.com", password: "secret", runner: false, surfer: true, surf_level: "confirmé", address: "15 rue Vanneau, 35230 Orgères", birthday: "13/05/1995"}, "ewena.jpg"],
  [{first_name: "Justine", last_name: "Brigand", email: "justine@me.com", password: "secret", runner: true, surfer: false, run_level: "débutant", address: "5 Rès le Golfe, 56000 Vannes", birthday: "15/08/1989"}, "justine.jpg"],
  [{first_name: "Hugo", last_name: "Daniels", email: "hugo@me.com", password: "secret", runner: false, surfer: true, surf_level: "débutant", address: "12 Rue Fallempin, 75015 Paris", birthday: "03/02/1981"}, "hugo.jpg"]
]
user_data.each do |u|
  user = User.create!(u.first)
  sleep 1
  file = File.open("db/fixtures/#{u.last}")
  user.avatar.attach(io: file, filename: u.last)
  user.save!
  sleep 1
  users << user
end

puts "Create favorite spots..."

fs1 = FavoriteSpot.create!(sport: "surf", city_spot: "Plouharnel", radius: 10, user_id: users[0].id)
sleep 1
fs2 = FavoriteSpot.create!(sport: "running", city_spot: "Vannes", radius: 3, user_id: users[0].id)
sleep 1
fs3 = FavoriteSpot.create!(sport: "surf", city_spot: "Fréhel", radius: 20, user_id: users[1].id)
sleep 1
fs4 = FavoriteSpot.create!(sport: "running", city_spot: "Rennes", radius: 3, user_id: users[1].id)
sleep 1
fs5 = FavoriteSpot.create!(sport: "running", city_spot: "Brest", radius: 3, user_id: users[5].id)
sleep 1

# puts "Scraping spots..."

# urla = "https://fr.wannasurf.com/spot/Europe/France/Brittany_South/index.html"
# html_filea = URI.open(urla).read
# html_doca = Nokogiri::HTML(html_filea)

# urlb = "https://fr.wannasurf.com/spot/Europe/France/Brittany_North/index.html"
# html_fileb = URI.open(urlb).read
# html_docb = Nokogiri::HTML(html_fileb)

# spots_data = []
# spots_photos_urls = []
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
#     photos_urls = "https://img.freepik.com/premium-vector/car-woman-surfing-beach-icon_571469-360.jpg?w=2000"
#   elsif icon_photo_tag[0].nil?
#     photos_urls = "https://img.freepik.com/premium-vector/car-woman-surfing-beach-icon_571469-360.jpg?w=2000"
#   else
#     # Chercher lien de redirection de toutes les photos
#     index_photo = doc.search(".wanna-showall-link")[0].attributes["href"].value
#     # Recréer le lien de redirection et ouvrir le document
#     index_url = "#{url.delete_suffix('index.html')}#{index_photo}"
#     index_html = URI.open(index_url).read
#     index_doc = Nokogiri::HTML(index_html)
#     # Préparer le stockage de chaque url de photo
#     each_photos_sub_urls = []
#     # Récupérer chaque élement avec une photo
#     photo_tag_urls = index_doc.search(".wanna-sublink")
#     photo_tag_urls.each_with_index do |nog_element, index|
#       each_photo_url = nog_element.attributes["href"].value.delete_prefix("index.html")
#       each_photos_sub_urls << each_photo_url if index.even?
#     end

#     each_photos_urls = []
#     each_photos_sub_urls.each do |sub_url|
#       each_photos_urls << "#{index_url}#{sub_url}"
#     end

#     # Pour chaque lien, ouvrir le lien avec open uri et Nogogirki
#     photos_urls = []
#     each_photos_urls.each do |photo_page_url|
#       photo_page_html = URI.open(photo_page_url).read
#       photo_doc = Nokogiri::HTML(photo_page_html)
#       # Chercher et stocker l'url de la photo
#       photo_sub_url = photo_doc.search(".photo-frame")[0].attributes["src"].value
#       photo_url = "https://fr.wannasurf.com#{photo_sub_url}"
#       photos_urls << photo_url
#     end
#   end
#   spots_photos_urls << photos_urls

#   # Scraping des coordonnées
#   lat = doc.at('span.wanna-item-label-gps:contains("Latitude")')&.next_sibling&.text
#   # p lat
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
#     # p lat_DD
#   end

#   lng = doc.at('span.wanna-item-label-gps:contains("Longitude")')&.next_sibling&.text
#   # p lng
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
#     # p lng_DD
#   end
#   spots_coord << [lat_DD, lng_DD]
# end
# puts "Nombre de spots: "
# p spots_data.count
# puts "Nombre de spots urls: "
# p spots_photos_urls.count
# puts "Nombre de coordonnées : "
# p spots_coord.count

# puts "Creating spots"

# sleep 1
# spots = []
# spots_data.each_with_index do |s, index|
#   spot = Spot.create!(s.first)
#   sleep 1
#   # file = File.open("db/fixtures/#{u.last}")
#   # user.avatar.attach(io: file, filename: u.last)
#   # user.save!
#   spot_photos_urls = spots_photos_urls[index]
#   if spot_photos_urls.class == Array
#     spot_photos_urls.each do |photo_url|
#       photo = ""
#       begin
#         photo = URI.open(photo_url)
#       rescue
#         next
#       end
#       spot.photos.attach(io: photo, filename: "#{index}.png", content_type: 'image/jpg')
#       spot.save!
#     end
#   else
#     photo = ""
#     begin
#       photo = URI.open(spot_photos_urls)
#     rescue
#       next
#     end
#     spot.photos.attach(io: photo, filename: "#{index}.png", content_type: 'image/jpg')
#     spot.save!
#   end
#   spot_coord = spots_coord[index]
#   spot.latitude = spot_coord.first
#   spot.longitude = spot_coord.last
#   spot.save!
#   spots << spot
# end

puts "Creating run_details..."

rd1 = RunDetail.create!(
  run_type: "fractionné",
  distance: 4,
  pace: "4:00",
  duration: 20,
  elevation: 10,
  location: "20 Rue Jules Vallès, 35000 Rennes"
)

rd2 = RunDetail.create!(
  run_type: "sortie longue",
  distance: 18,
  pace: "6:00",
  duration: 100,
  elevation: 120,
  location: "Place de la République, 35000 Rennes"
)

rd3 = RunDetail.create!(
  run_type: "footing",
  distance: 10,
  pace: "5:30",
  duration: 55,
  elevation: 100,
  location: "11 Rue de Châtillon, 35000 Rennes"
)

rd4 = RunDetail.create!(
  run_type: "VMA",
  distance: 6,
  pace: "3:45",
  duration: 24,
  elevation: 10,
  location: "13 Rue Zacharie Roussin, 35700 Rennes"
)

rd5 = RunDetail.create!(
  run_type: "allure spécifique",
  distance: 6,
  pace: "4:30",
  duration: 45,
  elevation: 20,
  location: "8 Av. des Gayeulles, 35700 Rennes"
)

rd6 = RunDetail.create!(
  run_type: "trail",
  distance: 24,
  pace: "4:30",
  duration: 132,
  elevation: 600,
  location: "La Piverdière, 35000 Rennes"
)

rd7 = RunDetail.create!(
  run_type: "marche nordique",
  distance: 15,
  pace: "10:00",
  duration: 150,
  elevation: 150,
  location: "2 b Rue Malaguti, 35000 Rennes"
)
rd8 = RunDetail.create!(
  run_type: "footing",
  distance: 8,
  pace: "5:30",
  duration: 44,
  elevation: 20,
  location: "68 Mail François Mitterrand, 35000 Rennes"
)

rd9 = RunDetail.create!(
  run_type: "côtes",
  distance: 8,
  pace: "5:15",
  duration: 42,
  elevation: 500,
  location: "Parc du Thabor, 35000 Rennes"
)
sleep 1
puts "Creating running events..."

events = []
event1 = Event.new(
  event_type: "running",
  name: "Fractionné",
  date: DateTime.new(2022, 12, 11, 15),
  description: "Fractionné le long de la Vilaine à plusieurs pour se motiver! 12 x 300 m à 15km/h, 40 secondes de récupération entre les séries",
  max_people: 20,
  meeting_point: "20 Rue Jules Vallès, 35000 Rennes",
  difficulty: "confirmé",
  run_detail_id: rd1.id
)
file = File.open("db/fixtures/vilaine.jpg")
event1.photos.attach(io: file, filename: "vilaine.jpg")

event1.organizer = users[2]
event1.save!
sleep 1
events << event1
Participation.create(event: event1, user: event1.organizer)

event2 = Event.new(
  event_type: "running",
  name: "Sortie longue",
  date: DateTime.new(2022, 12, 4, 12, 30),
  description: "Sortie longue à un rythme tranquille. Départ du centre de Rennes",
  meeting_point: "Place de la République, 35000 Rennes",
  max_people: 8,
  difficulty: "débutant",
  run_detail_id: rd2.id
)
file = File.open("db/fixtures/centre-rennes.jpg")
event2.photos.attach(io: file, filename: "centre-rennes.jpg")

event2.organizer = users[4]
event2.save!
sleep 1
events << event2
Participation.create(event: event2, user: event2.organizer)

event3 = Event.new(
  event_type: "running",
  name: "10km nocture",
  date: DateTime.new(2022, 12, 10, 18),
  description: "Sortie en soirée, pensez à votre lampe frontale 😉",
  meeting_point: "11 Rue de Châtillon, 35000 Rennes",
  max_people: 10,
  difficulty: "intermédiaire",
  run_detail_id: rd3.id
)
file = File.open("db/fixtures/photo-vitre.jpg")
event3.photos.attach(io: file, filename: "photo-vitre.jpg")

event3.organizer = users[6]
event3.save!
sleep 1
events << event3
Participation.create(event: event3, user: event3.organizer)

event4 = Event.new(
  event_type: "running",
  name: "Entrainement 10km",
  date: DateTime.new(2022, 12, 11, 14),
  description: "Séance d'entrainement à la piste du Stade Rennais Athéltisme en préparation de la course Tout Betton Court. 2 séries de 6 x 300m à 100% VMA 16km/h avec une récupération de 45 secondes entre les 300m et 3 minutes entre les séries.",
  meeting_point: "13 Rue Zacharie Roussin, 35700 Rennes",
  max_people: 5,
  difficulty: "confirmé",
  run_detail_id: rd4.id
)
file = File.open("db/fixtures/photo-brequigny.jpg")
event4.photos.attach(io: file, filename: "photo-brequigny.jpg")

event4.organizer = users[2]
event4.save!
sleep 1
events << event4
Participation.create(event: event4, user: event4.organizer)

event5 = Event.new(
  event_type: "running",
  name: "Allure spécifique",
  date: DateTime.new(2022, 12, 12, 12, 30),
  description: "Entraînement à allure spécifique dans le Parc des Gayeulles. Echauffement, puis 6 x 1km à 4:30/km, récupération 1min entre chaque série",
  meeting_point: "8 Av. des Gayeulles, 35700 Rennes",
  max_people: 30,
  difficulty: "intermédiaire",
  run_detail_id: rd5.id
)
file = File.open("db/fixtures/photo-loudeac.jpg")
event5.photos.attach(io: file, filename: "photo-loudeac.jpg")

event5.organizer = users[6]
event5.save!
sleep 1
events << event5
Participation.create(event: event5, user: event5.organizer)

event6 = Event.new(
  event_type: "running",
  name: "Trail aux étangs",
  date: DateTime.new(2022, 12, 10, 10),
  description: "Trail aux étangs d'Apignés pour éliminer avant les fêtes, venez motivés et bien équipés !",
  meeting_point: "La Piverdière, 35000 Rennes",
  max_people: 7,
  difficulty: "confirmé",
  run_detail_id: rd6.id
)
file = File.open("db/fixtures/photo-fougeres.jpg")
event6.photos.attach(io: file, filename: "photo-fougeres.jpg")

event6.organizer = users[5]
event6.save!
sleep 1
events << event6
Participation.create(event: event6, user: event6.organizer)

event7 = Event.new(
  event_type: "running",
  name: "Marche nordique",
  date: DateTime.new(2022, 12, 11, 10, 30),
  description: "Venez essayer la marche nordique à Rennes.",
  meeting_point: "2 b Rue Malaguti, 35000 Rennes",
  max_people: 10,
  difficulty: "débutant",
  run_detail_id: rd7.id
)
file = File.open("db/fixtures/marche.jpeg")
event7.photos.attach(io: file, filename: "marche.jpeg")

event7.organizer = users[4]
event7.save!
sleep 1
events << event7
Participation.create(event: event7, user: event7.organizer)

event8 = Event.new(
  event_type: "running",
  name: "Footing tranquille",
  date: DateTime.new(2022, 12, 11, 15),
  description: "Footing tranquille le long de la Vilaine, rdv au bout du Mail",
  meeting_point: "68 Mail François Mitterrand, 35000 Rennes",
  max_people: 10,
  difficulty: "débutant",
  run_detail_id: rd8.id
)
file = File.open("db/fixtures/tranquille-vilaine.jpeg")
event8.photos.attach(io: file, filename: "tranquille-vilaine.jpeg")

event8.organizer = users[5]
event8.save!
sleep 1
events << event8
Participation.create(event: event8, user: event8.organizer)

event9 = Event.new(
  event_type: "running",
  name: "Entraînement côtes",
  date: DateTime.new(2022, 12, 13, 17, 45),
  description: "Entraînement côtes au parc du Thabor.",
  meeting_point: "Parc du Thabor, 35000 Rennes",
  max_people: 5,
  difficulty: "confirmé",
  run_detail_id: rd9.id
)
file = File.open("db/fixtures/escaliers.jpg")
event9.photos.attach(io: file, filename: "escaliers.jpg")

event9.organizer = users[2]
event9.save!
sleep 1
events << event9
Participation.create(event: event9, user: event9.organizer)

puts "9 running events created!"

puts "Creating surf events..."

event10 = Event.new(
  event_type: "surf",
  name: "Session à Quiberon",
  date: DateTime.new(2022, 11, 19, 8, 30),
  description: "Session surf à Quiberon au départ de Rennes, rdv au métro Villejean",
  meeting_point: "10 rue du Rue Doyen Denis Leroy, 35000 Rennes",
  car_pooling: true,
  passengers: 2,
  difficulty: "débutant",
  spot_id: Spot.find_by(location: "Saint Pierre Quiberon - Port Blanc").id
)
file = File.open("db/fixtures/surf-port-blanc.jpg")
event10.photos.attach(io: file, filename: "surf-port-blanc.jpg")

event10.organizer = users[0]
event10.save!
sleep 1
events << event10
Participation.create(event: event10, user: event10.organizer)

event11 = Event.new(
  event_type: "surf",
  name: "Session à Fréhel",
  date: DateTime.new(2022, 12, 12, 9),
  description: "Session surf au Cap Fréhel au départ de la gare de Rennes",
  meeting_point: "19 Place de la Gare, 35005 Rennes",
  car_pooling: true,
  passengers: 4,
  difficulty: "intermédiaire",
  spot_id: Spot.find_by(location: "Cap frehel").id
)
file = File.open("db/fixtures/photo-cap-frehel.jpg")
event11.photos.attach(io: file, filename: "photo-cap-frehel.jpg")

event11.organizer = users[0]
event11.save!
sleep 1
events << event11
Participation.create(event: event11, user: event11.organizer)

event12 = Event.new(
  event_type: "surf",
  name: "Session aux Rosaires",
  date: DateTime.new(2022, 11, 26, 11),
  description: "Session détente, ramenez votre pique-nique !",
  meeting_point: "2D Rue de la Croix Lormel, 22190 Plérin",
  car_pooling: true,
  passengers: 5,
  difficulty: "débutant",
  spot_id: Spot.find_by(location: "Les Rosaires").id
)
file = File.open("db/fixtures/photo-rosaires.jpg")
event12.photos.attach(io: file, filename: "photo-rosaires.jpg")

event12.organizer = users[0]
event12.save!
sleep 1
events << event12
Participation.create(event: event12, user: event12.organizer)

event13 = Event.new(
  event_type: "surf",
  name: "Session à Aber",
  date: DateTime.new(2022, 12, 11, 11),
  description: "Session de surf à Tregana, spot très agréable",
  meeting_point: "13-25 Bon Plaisir, 29870 Landéda",
  car_pooling: true,
  passengers: 4,
  difficulty: "débutant",
  spot_id: Spot.find_by(location: "Aber wrac'h point").id
)
file = File.open("db/fixtures/photo-aber.jpg")
event13.photos.attach(io: file, filename: "photo-aber.jpg")

event13.organizer = users[2]
event13.save!
sleep 1
events << event13
Participation.create(event: event13, user: event13.organizer)

event14 = Event.new(
  event_type: "surf",
  name: "Session à Tregana",
  date: DateTime.new(2022, 12, 13, 14),
  description: "Spot dificile, attention au shortbreak ! Départ de Brest !",
  meeting_point: "Château de Brest, Bd de la Marine, 29200 Brest",
  car_pooling: true,
  passengers: 2,
  difficulty: "confirmé",
  spot_id: Spot.find_by(location: "Tregana").id
)
file = File.open("db/fixtures/photo-tregana.jpg")
event14.photos.attach(io: file, filename: "photo-tregana.jpg")

event14.organizer = users[6]
event14.save!
sleep 1
events << event14
Participation.create(event: event14, user: event14.organizer)

puts "4 surf events created!"

puts "Creating participations..."

Participation.create!(event_id: events[0].id, user_id: users[0].id)
Participation.create!(event_id: events[0].id, user_id: users[3].id)
Participation.create!(event_id: events[0].id, user_id: users[5].id)
Participation.create!(event_id: events[1].id, user_id: users[1].id)
Participation.create!(event_id: events[1].id, user_id: users[6].id)
Participation.create!(event_id: events[2].id, user_id: users[0].id)
Participation.create!(event_id: events[7].id, user_id: users[0].id)
Participation.create!(event_id: events[9].id, user_id: users[1].id)
Participation.create!(event_id: events[10].id, user_id: users[3].id)
Participation.create!(event_id: events[11].id, user_id: users[1].id)

puts "Creating meteos.."

Meteo.create(
  event_id: events[0].id,
  report_datetime: DateTime.now,
  weather: "Journée globalement ensoleillée",
  temperature: "10",
  wind_km: "12",
  wind_direction: 35
)
Meteo.create(
  event_id: events[1].id,
  report_datetime: DateTime.now,
  weather: "Journée partiellement nuageuse",
  temperature: "15",
  wind_km: "16",
  wind_kt: "34",
  wind_direction: 35,
  wave_height: 3,
  wave_period: 2,
  wave_direction: 45,
  sea_temperature: 10,
  coef: 89,
  previous_tide_type: "marée-basse",
  previous_tide_time: Time.now - 2,
  next_tide_type: "marée-haute",
  next_tide_time: Time.now + 6
)
Meteo.create(
  event_id: events[2].id,
  report_datetime: DateTime.now,
  weather: "Journée globalement ensoleillée",
  temperature: "15",
  wind_km: "9",
  wind_direction: 132
)

puts "Creating reviews..."

Review.create!(
  event_id: events[2].id,
  user_id: users[0].id,
  rating_event: 3,
  rating_difficulty: 2,
  rating_spot: 3,
  content: ""
)
Review.create!(
  event_id: events[2].id,
  user_id: users[1].id,
  rating_event: 3,
  rating_difficulty: 1,
  rating_spot: 2,
  content: "Petite sortie sympa"
)
Review.create!(
  event_id: events[2].id,
  user_id: users[2].id,
  rating_event: 1,
  rating_difficulty: 3,
  rating_spot: 1,
  content: "Ouais...ok."
)

fs1.spot = Spot.find_by(location: "Cap frehel")

fs3.spot = Spot.find_by(location: "Plouharnel - La Guérite Tata beach")

puts "Creating chatrooms..."

sortie1 = Event.find_by(name: "Sortie longue")

chat1 = Chatroom.create!(
  event: sortie1,
  name: sortie1.name,
  created_at: DateTime.new(2022, 12, 4, 12, 20)
)

message1 = Message.create!(
  chatroom: chat1,
  user: User.find_by(first_name: "Gwendal"),
  content: "Hello on se retrouve ou du coup ?",
  created_at: DateTime.new(2022, 12, 3, 12, 30)
)

sortie2 = Event.find_by(name: "Session à Quiberon")

chat2 = Chatroom.create!(
  event: sortie2,
  name: sortie2.name,
  created_at: DateTime.new(2022, 11, 19, 8, 30)
)

message1 = Message.create!(
  chatroom: chat2,
  user: User.find_by(first_name: "Gwendal"),
  content: "Hello les conditions sont top !",
  created_at: DateTime.new(2022, 11, 16, 8, 30)
)

sortie3 = Event.find_by(name: "Session aux Rosaires")

chat3 = Chatroom.create!(
  event: sortie3,
  name: sortie3.name,
  created_at: DateTime.new(2022, 11, 24, 11, 32)
)

message1 = Message.create!(
  chatroom: chat3,
  user: User.find_by(first_name: "Clément"),
  content: "Hello les conditions sont top !",
  created_at: DateTime.new(2022, 11, 25, 11, 38)
)

sortie4 = Event.find_by(name: "Session à Fréhel")

chat4 = Chatroom.create!(
  event: sortie4,
  name: sortie4.name,
  created_at: DateTime.new(2022, 12, 6, 11, 40)
)

message1 = Message.create!(
  chatroom: chat4,
  user: User.find_by(first_name: "Clément"),
  content: "Hello à tous j'ai encore des places dispo en covoiturage si ça vous tente !",
  created_at: DateTime.new(2022, 12, 7, 11)
)
message2 = Message.create!(
  chatroom: chat4,
  user: User.find_by(first_name: "Olivier"),
  content: "Salut ! Parfait ça m'intéresse",
  created_at: DateTime.new(2022, 12, 7, 12, 35)
)
message3 = Message.create!(
  chatroom: chat4,
  user: User.find_by(first_name: "Clément"),
  content: "Je pars de Rennes, quelle taille fait ta planche ?",
  created_at: DateTime.new(2022, 12, 8, 13, 15)
)

message4 = Message.create!(
  chatroom: chat4,
  user: User.find_by(first_name: "Olivier"),
  content: "J'ai une longboard c'est une 8.0",
  created_at: DateTime.new(2022, 12, 8, 13, 45)
)

message5 = Message.create!(
  chatroom: chat4,
  user: User.find_by(first_name: "Clément"),
  content: "Ok parfait j'ai une 8.0 aussi ça passe niquel dans ma voiture, envoie ton num !",
  created_at: DateTime.new(2022, 12, 8, 13, 55)
)

message6 = Message.create!(
  chatroom: chat4,
  user: User.find_by(first_name: "Olivier"),
  content: "06.34.32.34.53, j'habite 2 rue du grand olivier à Rennes !",
  created_at: DateTime.new(2022, 12, 8, 14, 56)
)

message7 = Message.create!(
  chatroom: chat4,
  user: User.find_by(first_name: "Clément"),
  content: "Ok parfait merci, je passerai te prendre !",
  created_at: DateTime.new(2022, 12, 8, 14, 58)
)

sortie5 = Event.find_by(name: "Footing tranquille")

chat5 = Chatroom.create!(
  event: sortie5,
  name: sortie5.name,
  created_at: DateTime.new(2022, 12, 8, 12)
)

message1 = Message.create!(
  chatroom: chat5,
  user: User.find_by(first_name: "Justine"),
  content: "Hello à tous ! On se retrouve 10min avant pour s'échauffer ?",
  created_at: DateTime.new(2022, 12, 8, 12, 30)
)

message2 = Message.create!(
  chatroom: chat5,
  user: User.find_by(first_name: "Clément"),
  content: "Salut ! Yes carrément !",
  created_at: DateTime.new(2022, 12, 8, 12, 45)
)

message3 = Message.create!(
  chatroom: chat5,
  user: User.find_by(first_name: "Justine"),
  content: "Top, à dimanche !",
  created_at: DateTime.new(2022, 12, 8, 13)
)
