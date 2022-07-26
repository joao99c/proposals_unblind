# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create([
              { email: 'ld@unblind.io', name: 'Luís Diogo', password: 123_123_123 },
              { email: 'jc@unblind.io', name: 'Jota Carvalho', password: 123_123_123 }
            ])

100.times do
  Customer.create(name: Faker::Name.name, email: Faker::Internet.email)
end

Deal.destroy_all
50.times do
  Deal.create(
    name: Faker::Name.name,
    user: User.find(User.pluck(:id).sample),
    customer: Customer.find(Customer.pluck(:id).sample),
    finish_date: DateTime.now + rand(30).day
  )
end

Product.destroy_all
50.times do
  Product.create(
    name: Faker::Commerce.product_name,
    price: Faker::Number.decimal,
    description: Faker::Lorem.paragraph
  )
end

DealProduct.destroy_all
DealProduct.create(deal: Deal.find(Deal.pluck(:id).sample), product: Product.find(Product.pluck(:id).sample),
                   quantity: rand(1..10))
