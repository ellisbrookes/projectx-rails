FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence(word_count: 10).gsub(/[^0-9a-zA-Z\s]/, '') }
    user_id { 1 }
    task_id { 1 }
  end
end
