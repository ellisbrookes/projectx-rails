FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence(word_count: 20) }
    user_id { 1 }
    task_id { 1 }
  end
end
