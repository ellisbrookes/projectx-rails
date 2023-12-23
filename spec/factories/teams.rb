FactoryBot.define do
  factory :team do
    name { Faker::Company.name }
    description { Faker::Company.catch_phrase }
    team_email { Faker::Internet.email }
    team_members { 1 }
    company_id { 1 }
    user_id { 1 }
  end
end
