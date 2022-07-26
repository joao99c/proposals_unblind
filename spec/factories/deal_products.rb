FactoryBot.define do
  factory :deal_product do
    deal { nil }
    product { nil }
    discount_amount { "MyString" }
    discount_type { "MyString" }
  end
end
