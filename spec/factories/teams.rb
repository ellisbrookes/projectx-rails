FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
    description { Faker::Lorem.sentence(word_count: 20) }
    email { Faker::Internet.email }
    company_id { 1 }
  end
end
