# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.find_or_create_by!(email: 'user@mail.com') do |new_user|
  new_user.name = 'user'
  new_user.password = 'password'
end
city = City.find_or_create_by!(name: 'Philly')
real_estate = RealEstate.find_or_create_by!(host: user, city: city, title: 'Nice House', estate_type: 1, price: 5000)
(1..20).each { |i| Day.find_or_create_by!(date: i.days.from_now, real_estate: real_estate)} 
Day.all[10].update(taken: true)

puts 'Seed Done.'