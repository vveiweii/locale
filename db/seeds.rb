require 'faker'

postcodes = ['3002', '8002', '3000', '3001', '3004', '8001', '3045', '3052', '5006', '3051', '3207', '3050', '3205', '3004', '3010', '3003']

p "Starting seed"
p "Destroying all users"
User.destroy_all

p "creating master user test@test.com with password 123456"
User.create!(
  name: 'Master User',
  email: 'test@test.com',
  address: Faker::Address.street_address,
  password: '123456',
  city: 'Melbourne',
  state: 'VIC',
  postcode: 3000
)
p "Master user created"

puts "Creating regular users"
10.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    address: Faker::Address.street_address,
    password: '123456',
    city: 'Melbourne',
    state: 'VIC',
    postcode: postcodes.sample
  )
end
p "Regular users created"

puts "Creating businesses"
User.all.sample(10).each do |user|
  user.businesses.create(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    address: Faker::Address.street_address,
    city: 'Melbourne',
    state: 'VIC',
    postcode: postcodes.sample,
    description: Faker::Company.industry,
    available: 'yes'
  )
end
puts "Businesses created"

puts "Creating services"
Business.all.each do |business|
  5.times do
    business.services.create(
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price(range: 50.0..300.0),
      offer: 0,
      description: Faker::Commerce.product_name,
      available: 'yes'
    )
  end
  3.times do
    business.services.create(
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price(range: 150.0..300.0),
      offer: Faker::Commerce.price(range: 50.0..100.0),
      description: Faker::Commerce.product_name,
      available: 'yes'
    )
  end
end
puts "Services created"
