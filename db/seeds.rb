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

# Customer.destroy_all
100.times do
  Customer.create(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    responsable_name: Faker::Name.name,
    responsable_email: Faker::Internet.email,
    website: Faker::Internet.url,
    responsable_tel: Faker::PhoneNumber.phone_number
  )
end

# Deal.destroy_all
50.times do
  Deal.create(
    name: Faker::Name.name,
    user: User.find(User.pluck(:id).sample),
    customer: Customer.find(Customer.pluck(:id).sample),
    finish_date: DateTime.now + rand(30).day,
    status: %w[open won lost].sample
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

['Conteúdo Básico', 'Destaques', 'Testemunhos', 'Equipa', 'Imagens', 'Videos',
 'FAQ’s'].each_with_index do |word, position,|
  SectionCategory.create(name: word, position:)
end
Section.destroy_all
Section.create!([name: 'text', section_category: SectionCategory.first])
Section.create!([name: 'bio', section_category: SectionCategory.first])
Section.create!([name: 'grid', section_category: SectionCategory.first])

DealSection.destroy_all
DealSection.create({
                     deal_id: 50,
                     section_id: 1,
                     preHeading: 'Pre Heading',
                     heading: 'Heading',
                     subHeading: 'Sub Heading',
                     theme: {
                       name: 'none',
                       colors: {
                         background: '#ffffff',
                         button: '#4b2aad',
                         buttonText: '#ffffff',
                         heading: '#0d161b',
                         text: '#0d161b'
                       },
                       background: {
                         blend: 'normal',
                         blur: 0,
                         contrast: 75,
                         grayscale: 100,
                         opacity: 38,
                         url: nil
                       }
                     },
                     button: {
                       text: 'Button',
                       url: 'https://www.google.com'
                     },
                     button2: {
                       text: 'Button 2',
                       url: 'https://www.google.com'
                     },
                     links: {
                       twitter: {
                         position: 0,
                         name: 'twitter',
                         url: '1'
                       },
                       facebook: {
                         position: 1,
                         name: 'facebook',
                         url: '1'
                       },
                       instagram: {
                         position: 2,
                         name: 'instagram',
                         url: '1'
                       },
                       pinterest: {
                         position: 3,
                         name: 'pinterest',
                         url: '1'
                       },
                       linkedin: {
                         position: 4,
                         name: 'linkedin',
                         url: '1'
                       },
                       youtube: {
                         position: 5,
                         name: 'youtube',
                         url: '1'
                       },
                       tiktok: {
                         position: 6,
                         name: 'tiktok',
                         url: '1'
                       },
                       website: {
                         position: 7,
                         name: 'website',
                         url: '1'
                       },
                       mailto: {
                         position: 8,
                         name: 'mailto',
                         url: 'mailto:1'
                       }
                     },
                     buttonSubtext: 'Button Subtext',
                     text: 'Im a text',
                     mediaAlignment: 'left', # left, center, right ...
                     mediaStyle: 'plain' # plain, card ...
                   })

parent = Admin::Editor::GridSection.new(
  deal_id: 50,
  section: Section.find_by_name('grid'),
  preHeading: 'Pre Heading',
  heading: 'Heading',
  subHeading: 'Sub Heading'
).becomes(DealSection)
parent.save

child1 = Admin::Editor::TextSection.new(
  deal_id: 50,
  section: Section.find_by_name('text'),
  preHeading: 'Pre Heading',
  heading: 'Heading',
  subHeading: 'Sub Heading',
  child: true,
  parent_id: parent.id
).becomes(DealSection)
child1.save

DealSectionItem.create({
                         parent_id: parent.id,
                         child_id: child1.id,
                         position: 0
                       })
