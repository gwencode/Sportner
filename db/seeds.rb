# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Destroying events"
Event.destroy_all

puts "Destroying users"
User.destroy_all

puts "Creating users"
users = []
user_data = [
  [{first_name: "Clément", last_name: "Cordeiro", email: "clement@me.com", password: "secret", runner: true, surfer: true, address: "9 avenue du président Edouard Heriot", zipcode: "56000", city: "Vannes", birthday: "26/11/1994"}],
  [{first_name: "Gwendal", last_name: "Le Bris", email: "gwendal@me.com", password: "secret", runner: true, surfer: true, address: "135 rue la Marck", zipcode: "75018", city: "Paris", birthday: "12/06/1995"}],
  [{first_name: "Matthieu", last_name: "Nourry", email: "matthieu@me.com", password: "secret", runner: true, surfer: false, address: "labidois", zipcode: "35490", city: "Romazy", birthday: "29/07/2000"}],
  [{first_name: "Olivier", last_name: "Kermoal", email: "olivier@me.com", password: "secret", runner: true, surfer: false, address: "4 avenue de la mare Guesclin", zipcode: "35230", city: "Saint-Erblon", birthday: "17/09/1990"}],
  [{first_name: "Ewena", last_name: "Bressa", email: "ewena@me.com", password: "secret", runner: false, surfer: true, address: "15 rue Vanneau", zipcode: "35230", city: "Orgères", birthday: "13/05/1995"}],
  [{first_name: "Justine", last_name: "Brigand", email: "justine@me.com", password: "secret", runner: true, surfer: false, address: "5 Rès le Golfe", zipcode: "56000", city: "Vannes", birthday: "15/08/1989"}],
  [{first_name: "Magalie", last_name: "Girard", email: "magalie@me.com", password: "secret", runner: false, surfer: true, address: "12 Rue Fallempin", zipcode: "75015", city: "Paris", birthday: "03/02/1981"}]
]
user_data.each do |u|
  user = User.create!(u.first)
  # file = File.open("db/fixtures/#{u.last}")
  # user.avatar.attach(io: file, filename: u.last)
  # user.save!
  users << user
end

puts "7 users created"
puts "_______________"

puts "Creating events"
event1 = Event.new(
  event_type: "Running",
  name: "Sortie longue",
  date: DateTime.now + 7,
  description: "Sortie longue le long de la Vilaine à plusieurs pour se motiver!",
  max_people: 20,
  meeting_point: "Place de la République, 35000 Rennes",
  difficulty: "intermédiaire",
)
event1.organizer = users[1]
event1.save!

event2 = Event.new(
  event_type: "Surf",
  name: "Session à Quiberon",
  date: DateTime.now + 10,
  description: "Session surf à Quiberon au départ de Rennes",
  meeting_point: "Place de la République, 35000 Rennes",
  car_pooling: true,
  passengers: 2,
  difficulty: "débutant",
)
event2.organizer = User.first
event2.save!

puts "2 events created"
