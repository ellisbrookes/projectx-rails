FactoryBot.define do
  factory :item do
    invoice_id { 1 }
    quantity { Faker::Number.within(range: 1..9) }
    company_id { 1 }
    description { Faker::Lorem.sentence(word_count: 20) }
    unit_price { Faker::Commerce.price }
    name { Faker::Company.name }
  end
end
