FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "testing1234" }
    confirmed_at { Time.now }
    is_admin { false }
  end

  factory :admin do
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "admin1234" }
    confirmed_at { Time.now }
    is_admin { true }
  end
end
