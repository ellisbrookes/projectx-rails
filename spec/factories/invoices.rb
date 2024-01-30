FactoryBot.define do
  factory :invoice do
    invoice_issue { Faker::Number.within(range: 1..1000) }
    customer { Faker::Company.name }
    customer_address { Faker::Address.full_address }
    company_address { Faker::Address.full_address }
    issue_date { Faker::Date.backward(days: 30) }
    due_date { Faker::Date.forward(days: 30) }
    amount { Faker::Commerce.price }
    notes { Faker::Lorem.sentence(word_count: 20) }
    company_id { 1 }
  end
end
