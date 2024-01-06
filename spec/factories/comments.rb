FactoryBot.define do
  factory :comment do
    body { Faker::Quote.jack_handey }
    user_id { 1 }
    task_id { 1 }
  end
end
