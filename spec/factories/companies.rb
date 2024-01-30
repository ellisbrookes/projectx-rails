FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
    description { Faker::Lorem.sentence(word_count: 20) }
    email { Faker::Internet.email }
    user_id { 1 }
  end
end
