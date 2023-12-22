FactoryBot.define do
  factory :teams do
    name { Faker::Company.name }
    description { Faker::Company.catch_phrase }
    team_email { Faker::Internet.email }
    company_id { 1 }
    user_id { 1 }
  end
end