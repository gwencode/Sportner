require "open-uri"
require "nokogiri"

puts "cleaning DB..."
puts "destroying participations..."
Participation.destroy_all
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
puts "destroying spots..."
Spot.destroy_all
puts "destroying users..."
User.destroy_all
puts "...cleaning done!"

puts "Create users..."

users = []
user_data = [
  [{first_name: "Clément", last_name: "Cordeiro", email: "clement@me.com", password: "secret", runner: true, surfer: true, address: "9 avenue du président Edouard Heriot, 56000 Vannes", birthday: "26/11/1994"}, "clement.jpeg"],
  [{first_name: "Gwendal", last_name: "Le Bris", email: "gwendal@me.com", password: "secret", runner: true, surfer: true, address: "135 rue la Marck, 75018 Paris", birthday: "12/06/1995"}, "gwendal.jpeg"],
  [{first_name: "Matthieu", last_name: "Nourry", email: "matthieu@me.com", password: "secret", runner: true, surfer: false, address: "labidois, 35490 Romazy", birthday: "29/07/2000"}, "matthieu.jpg"],
  [{first_name: "Olivier", last_name: "Kermoal", email: "olivier@me.com", password: "secret", runner: true, surfer: false, address: "4 avenue de la mare Guesclin, 35230 Saint-Erblon", birthday: "17/09/1990"}, "olivier.jpeg"],
  [{first_name: "Ewena", last_name: "Bressa", email: "ewena@me.com", password: "secret", runner: false, surfer: true, address: "15 rue Vanneau, 35230 Orgères", birthday: "13/05/1995"}, "ewena.jpg"],
  [{first_name: "Justine", last_name: "Brigand", email: "justine@me.com", password: "secret", runner: true, surfer: false, address: "5 Rès le Golfe, 56000 Vannes", birthday: "15/08/1989"}, "justine.jpg"],
  [{first_name: "Hugo", last_name: "Daniels", email: "hugo@me.com", password: "secret", runner: false, surfer: true, address: "12 Rue Fallempin, 75015 Paris", birthday: "03/02/1981"}, "hugo.jpg"]
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

FavoriteSpot.create!(sport: "surf", city_spot: "Plouharnel", radius: 3, user_id: users[0].id)
sleep 1
FavoriteSpot.create!(sport: "running", city_spot: "Rennes", radius: 1, user_id: users[0].id)
sleep 1
FavoriteSpot.create!(sport: "surf", city_spot: "Plomer", radius: 3, user_id: users[1].id)
sleep 1
FavoriteSpot.create!(sport: "running", city_spot: "Rennes", radius: 1, user_id: users[1].id)
sleep 1
FavoriteSpot.create!(sport: "running", city_spot: "Vannes", radius: 3, user_id: users[5].id)
sleep 1

puts "Create spots..."

urla = "https://fr.wannasurf.com/spot/Europe/France/Brittany_South/index.html"
html_filea = URI.open(urla).read
html_doca = Nokogiri::HTML(html_filea)

urlb = "https://fr.wannasurf.com/spot/Europe/France/Brittany_North/index.html"
html_fileb = URI.open(urlb).read
html_docb = Nokogiri::HTML(html_fileb)

spots_data = []
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
end

sleep 1
spots = []
spots_data.each do |s|
  spot = Spot.create!(s.first)
  sleep 1
  # file = File.open("db/fixtures/#{u.last}")
  # user.avatar.attach(io: file, filename: u.last)
  # user.save!
  spots << spot
end

puts "Creating run_details..."

RunDetail.create!(
  run_type: "fractionné",
  distance: 4,
  pace: "4:40",
  duration: 20,
  elevation: 3,
  location: "9 rue des dames, 35000 Rennes"
)
sleep 1
RunDetail.create!(
  run_type: "sortie longue",
  distance: 18,
  pace: "6:00",
  duration: 100,
  elevation: 12,
  location: "Quai Eric Tabarly, 35000 Rennes"
)
sleep 1
puts "Creating events..."

events = []
event1 = Event.new(
  event_type: "running",
  name: "Sortie longue",
  date: DateTime.now + 7,
  description: "Sortie longue le long de la Vilaine à plusieurs pour se motiver!",
  max_people: 20,
  meeting_point: "111 Rue de Lorient, 35000 Rennes",
  difficulty: "intermédiaire",
  run_detail_id: RunDetail.last.id
)

event1.organizer = users[1]
event1.save!
sleep 1
events << event1
event2 = Event.new(
  event_type: "surf",
  name: "Session à Quiberon",
  date: DateTime.now + 10,
  description: "Session surf à Quiberon au départ de Vannes",
  meeting_point: "Quai Bernard Moitessier, 56000 Vannes",
  car_pooling: true,
  passengers: 2,
  difficulty: "débutant",
  spot_id: Spot.find_by(location: "Saint Pierre Quiberon - Port Blanc").id
)

event2.organizer = users[0]
event2.save!
sleep 1
events << event2

event3 = Event.new(
  event_type: "running",
  name: "Course à Rennes",
  date: DateTime.now - 10,
  description: "Petite run dans le centre historique de Rennes",
  meeting_point: "Place de la République, 35000 Rennes",
  max_people: 8,
  difficulty: "confirmé",
  run_detail_id: RunDetail.first.id
)
event3.organizer = users[5]
event3.save!
sleep 1
events << event3

puts "Creating participation..."

Participation.create!(event_id: events[0].id, user_id: users[0].id)
Participation.create!(event_id: events[0].id, user_id: users[2].id)
Participation.create!(event_id: events[0].id, user_id: users[3].id)
Participation.create!(event_id: events[0].id, user_id: users[5].id)
Participation.create!(event_id: events[1].id, user_id: users[1].id)
Participation.create!(event_id: events[1].id, user_id: users[4].id)
Participation.create!(event_id: events[1].id, user_id: users[6].id)
Participation.create!(event_id: events[2].id, user_id: users[0].id)
Participation.create!(event_id: events[2].id, user_id: users[1].id)
Participation.create!(event_id: events[2].id, user_id: users[2].id)

puts "Creating meteos..."

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
