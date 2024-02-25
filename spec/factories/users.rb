FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "testing1234" }
    confirmed_at { Time.now }

    trait :admin do
      after(:create) { |user| user.add_role(:admin) }
    end
  end
end
