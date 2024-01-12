FactoryBot.define do
  factory :team do
    name { Faker::Team.name.gsub(/[^0-9a-zA-Z\s]/, '') }
    description { Faker::Lorem.sentence(word_count: 20) }
    email { Faker::Internet.email }
    company_id { 1 }
  end
end
