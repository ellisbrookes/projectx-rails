FactoryBot.define do
  factory :notification do
    user { nil }
    content { "MyText" }
    read { false }
  end
end
