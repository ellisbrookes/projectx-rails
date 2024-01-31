FactoryBot.define do
  factory :customer do#
    full_name { Faker::Name.name }
    address { Faker::Address.full_address }
    phone_number { Faker::PhoneNumber.phone_number_with_country_code }
    email { Faker::Internet.email }
    notes { Faker::Lorem.sentence(word_count: 20) }
    company_id { Faker::Number.within(range: 1..9) }
  end
end