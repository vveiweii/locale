require 'faker'

p "Starting seed"
p "Destroying all users"
User.destroy_all

p "creating master user test@test.com with password 123456"
User.create!(
  name: 'Master',
  email: 'test@test.com',
  password: '123456',
  city: 'Melbourne',
  state: 'VIC',
  postcode: 3000
)
p "Master user created"

puts "Creating regular users"
30.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '123456',
    city: Faker::Address.city
  )
end
p "Regular users created"

puts "Creating businesses"
User.all.sample(10).each do |user|
  user.businesses.create(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address,
    city: Faker::Address.city,
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
      description: Faker::Commerce.product_name,
      available: 'yes'
    )
  end
end
puts "Services created"
