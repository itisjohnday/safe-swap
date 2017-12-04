# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

phones = [['Apple', ['iPhone 6', 'iPhone 6+', 'iPhone 7', 'iPhone 7+', 'iPhone 8', 'iPhone 8+', 'iPhone X', ]], ['Samsung', ['Galaxy Note 8', 'Galaxy S8', 'Galaxy S8+']], ['Google', ['Pixel', 'Pixel XL', 'Pixel 2', 'Pixel 2 XL']]]

zipcodes = ['60622', '60614', '60640', '60616']

condition = ['like new', 'good', 'poor', 'for parts only']

filler = 1
50.times do
  email_entry = "test#{filler}@example.com"
  User.create!(first_name: "#{Faker::Seinfeld.character}", last_name: " ", email: email_entry, zipcode: zipcodes.sample, phone_number: '555-555-5555', password: '123456')
  filler += 1
end

20.times do
  device_manufacturer = phones[rand(0..2)][0]
  if device_manufacturer == 'Apple'
    device_model = phones[0][1][rand(0..6)]
  elsif device_manufacturer == 'Samsung'
    device_model = phones[1][1][rand(0..2)]
  else
    device_model = phones[2][1][rand(0..3)]
  end

  Device.create!(title: "#{Faker::Hipster.paragraph}", manufacturer: device_manufacturer, model: device_model, condition: condition[rand(0..3)], price: rand(100..500), buyer_id: rand(1..50), seller_id: rand(1..50), sold?: false)
end
