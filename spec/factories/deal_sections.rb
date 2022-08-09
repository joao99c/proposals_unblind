FactoryBot.define do
  factory :deal_section do
    deal { nil }
    section { nil }
    order { 1 }
    preheading { "MyString" }
    heading { "MyString" }
    subheading { "MyString" }
    buttonsubtext { "MyString" }
    theme { "" }
    background { "" }
    button { "" }
    button2 { "" }
    text { "MyText" }
    mediaAlignment { "MyString" }
    mediaStyle { "MyString" }
  end
end
