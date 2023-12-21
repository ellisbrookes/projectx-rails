FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    description { Faker::Company.catch_phrase }
    email { Faker::Internet.email }
    user_id { 1 }
  end
end
