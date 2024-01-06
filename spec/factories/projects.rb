FactoryBot.define do
  factory :project do
    title { Faker::Company.name }
    description { Faker::Company.catch_phrase }
    start_date { Faker::Date.backward(days: 30) }
    completion_date { Faker::Date.forward(days: 30) }
    team_id { 1 }
    company_id { 1 }
    estimated_budget { Faker::Commerce.price }
    actual_budget { Faker::Commerce.price }
  end
end
