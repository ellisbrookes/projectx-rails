FactoryBot.define do
  factory :company do
    name { "MyString" }
    description { "MyText" }
    email { "MyString" }
    user { nil }
  end
end
