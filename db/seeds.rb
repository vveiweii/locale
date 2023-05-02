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
users = []
30.times do
  user = User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '123456',
    city: Faker::Address.city
  )
  users << user
end
p "Regular users created"

puts "Creating businesses"
businesses = []
users.sample(10).each do |user|
  business = user.businesses.create(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    address: Faker::Address.full_address,
    city: Faker::Address.city,
    description: Faker::Company.bs,
    available: 'yes'
  )
  businesses << business
end
puts "Businesses created"

puts "Creating services"
businesses.each do |business|
  5.times do
    business.services.create(
      name: Faker::Commerce.product_name,
      price: Faker::Commerce.price(range: 50..300),
      description: Faker::Lorem.paragraph(sentence_count: 2),
      available: 'yes'
    )
  end
end
puts "Services created"
