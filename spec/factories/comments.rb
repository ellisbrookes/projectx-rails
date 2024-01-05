FactoryBot.define do
  factory :comment do
    body { "MyString" }
    user { nil }
    task { nil }
  end
end
