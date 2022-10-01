# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

['Templates', 'Wireframe'].each_with_index do |word, position,|
  SectionCategory.create(name: word, position:)
end

SectionType.destroy_all
%w[Mandatory Grid Gallery Content Accordion].each do |name|
  SectionType.create(name:)
end

Section.destroy_all
Section.create!([name: 'Cabeçalho', section_category: SectionCategory.first, section_type: SectionType.find_by_name('Mandatory')])
Section.create!([name: 'Proposta', section_category: SectionCategory.first, section_type: SectionType.find_by_name('Mandatory')])
Section.create!([name: 'Contacto', section_category: SectionCategory.first, section_type: SectionType.find_by_name('Mandatory')])

Section.create!([name: 'Grelha', section_category: SectionCategory.second, section_type: SectionType.find_by_name('Grid')])
Section.create!([name: 'Grelha_Filho', section_category: SectionCategory.second, section_type: SectionType.find_by_name('Grid')])
Section.create!([name: 'Galeria', section_category: SectionCategory.second, section_type: SectionType.find_by_name('Gallery')])
Section.create!([name: 'Conteúdo', section_category: SectionCategory.second, section_type: SectionType.find_by_name('Content')])
Section.create!([name: 'Acordeão', section_category: SectionCategory.second, section_type: SectionType.find_by_name('Accordion')])

Section.create!([name: 'Sobre Nós', section_category: SectionCategory.first, section_type: SectionType.find_by_name('Content')])
Section.create!([name: 'Equipa', section_category: SectionCategory.first, section_type: SectionType.find_by_name('Grid')])
Section.create!([name: 'Passo a passo', section_category: SectionCategory.first, section_type: SectionType.find_by_name('Grid')])
Section.create!([name: 'Portfolio', section_category: SectionCategory.first, section_type: SectionType.find_by_name('Gallery')])
Section.create!([name: 'Os nossos Clientes', section_category: SectionCategory.first, section_type: SectionType.find_by_name('Gallery')])
Section.create!([name: 'Faq’s', section_category: SectionCategory.first, section_type: SectionType.find_by_name('Accordion')])


User.create([
              { email: 'ld@unblind.io', first_name: 'Luís', last_name: 'Diogo', password: 123_123_123 },
              { email: 'jc@unblind.io', first_name: 'Jota', last_name: 'Carvalho', password: 123_123_123 },
              { email: 'madalenafigueirasdacosta@gmail.com', first_name: 'Madalena', last_name: 'Costa', password: 123_123_123 }
            ])

Font.create([
              { name: 'Roboto', weights: %w[300 400 700 900] },
              { name: 'Source Sans Pro', weights: %w[300 400 700 900] },
              { name: 'Raleway', weights: %w[300 400 700 900] },
              { name: 'Merriweather', weights: %w[300 400 700 900] },

              { name: 'Open Sans', weights: %w[300 400 700 800] },
              { name: 'Lato', weights: %w[300 400 700 800] },
              { name: 'Montserrat', weights: %w[100 200 300 400 500 700 600 800 900] },

              { name: 'Oswald', weights: %w[300 400 700] },
              { name: 'PT Sans', weights: %w[400 700] },
            ])

# Customer.destroy_all
100.times do
  Customer.create(
    name: Faker::Company.name,
    website: Faker::Internet.url,
    responsable_name: Faker::Name.name,
    responsable_email: Faker::Internet.email,
    responsable_tel: Faker::PhoneNumber.phone_number
  )
end

# Deal.destroy_all
50.times do
  user = User.find(User.pluck(:id).sample)
  Deal.create!(
    name: Faker::Name.name,
    user: ,
    customer: Customer.find(Customer.pluck(:id).sample),
    finish_date: DateTime.now + rand(30).day,
    status: %w[open won lost].sample,
    template: user.templates.first
  )
end

# Product.destroy_all
50.times do
  Product.create(
    name: Faker::Commerce.product_name,
    price: Faker::Number.decimal,
    description: Faker::Lorem.paragraph
  )
end

# DealProduct.destroy_all
50.times do
  DealProduct.create(deal: Deal.find(Deal.pluck(:id).sample), product: Product.find(Product.pluck(:id).sample),
                     quantity: rand(1..10))
end

# Tag.destroy_all
50.times do
  Tag.create(
    name: Faker::Name.name
  )
end

