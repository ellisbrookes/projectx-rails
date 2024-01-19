FactoryBot.define do
  factory :project do
    title { Faker::Company.name.gsub(/[^0-9a-zA-Z\s]/, '') }
    description { Faker::Lorem.sentence(word_count: 20) }
    start_date { Faker::Date.backward(days: 30) }
    completion_date { Faker::Date.forward(days: 30) }
    team_id { 1 }
    company_id { 1 }
    estimated_budget { Faker::Commerce.price }
    actual_budget { Faker::Commerce.price }
  end
end
