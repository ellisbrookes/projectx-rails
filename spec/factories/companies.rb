FactoryBot.define do
  sequence "comapny_email" do |n|
    "company#{n}@example.com"
  end

  factory :company do
    name { Faker.company.name }
    description { Faker::Company.catch_phrase }
    comapny_email
    user_id { 1 }
  end
end
