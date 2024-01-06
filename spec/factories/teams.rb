FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
    description { Faker::Company.catch_phrase }
    team_email { Faker::Internet.email }
    company_id { 1 }
  end
end
