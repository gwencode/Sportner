puts "cleaning DB..."
puts "destroying events..."
Event.destroy_all
puts "destroying reviews..."
Review.destroy_all
puts "destroying participations..."
Participation.destroy_all
puts "destroying favorite_spots..."
FavoriteSpot.destroy_all
puts "destroying itineraries..."
Itinerary.destroy_all
puts "destroying run_details..."
RunDetail.destroy_all
puts "destroying spots..."
Spot.destroy_all
puts "destroying meteos..."
Meteo.destroy_all
puts "destroying users..."
User.destroy_all
puts "...cleaning done!"

puts "Create users..."

users = []
user_data = [
  [{first_name: "Clément", last_name: "Cordeiro", email: "clement@me.com", password: "secret", runner: true, surfer: true, address: "9 avenue du président Edouard Heriot, 56000 Vannes", birthday: "26/11/1994"}]
  [{first_name: "Gwendal", last_name: "Le Bris", email: "gwendal@me.com", password: "secret", runner: true, surfer: true, address: "135 rue la Marck, 75018 Paris", birthday: "12/06/1995"}]
  [{first_name: "Matthieu", last_name: "Nourry", email: "matthieu@me.com", password: "secret", runner: true, surfer: false, address: "labidois, 35490 Romazy", birthday: "29/07/2000"}]
  [{first_name: "Olivier", last_name: "Kermoal", email: "olivier@me.com", password: "secret", runner: true, surfer: false, address: "4 avenue de la mare Guesclin, 35230 Saint-Erblon", birthday: "17/09/1990"}]
  [{first_name: "Ewena", last_name: "Bressa", email: "ewena@me.com", password: "secret", runner: false, surfer: true, address: "15 rue Vanneau, 35230 Orgères", birthday: "13/05/1995"}]
  [{first_name: "Justine", last_name: "Brigand", email: "justine@me.com", password: "secret", runner: true, surfer: false, address: "5 Rès le Golfe, 56000 Vannes", birthday: "15/08/1989"}]
  [{first_name: "Magalie", last_name: "Girard", email: "magalie@me.com", password: "secret", runner: false, surfer: true, address: "12 Rue Fallempin, 75015 Paris", birthday: "03/02/1981"}]
]
user_data.each do |u|
  user = User.create!(u.first)
  # file = File.open("db/fixtures/#{u.last}")
  # user.avatar.attach(io: file, filename: u.last)
  # user.save!
  users << user
end

puts "Create favorite spots..."

FavoriteSpot.create!(sport: "surf", city: "Plouharnel", radius: 3, user_id: users[0].id)
FavoriteSpot.create!(sport: "run", city: "Rennes", radius: 1, user_id: users[0].id)
FavoriteSpot.create!(sport: "surf", city: "Plomer", radius: 3, user_id: users[1].id)
FavoriteSpot.create!(sport: "run", city: "Rennes", radius: 1, user_id: users[1].id)
FavoriteSpot.create!(sport: "run", city: "Vannes", radius: 3, user_id: users[5].id)

puts "Create spots..."

spots = []
spot_data = [
  []
]
