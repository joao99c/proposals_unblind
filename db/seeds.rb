# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create([
              { email: 'ld@unblind.io', name: 'Luís Diogo', password: 123123123 },
              { email: 'jc@unblind.io', name: 'Jota Carvalho', password: 123123123 }
            ])

100.times do
  Customer.create(name: Faker::Name.name, email: Faker::Internet.email)
end

50.times do
  Deal.create(user: User.find(User.pluck(:id).sample), customer: Customer.find(Customer.pluck(:id).sample))
end