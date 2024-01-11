FactoryBot.define do
  factory :task do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence(word_count: 20) }
    due_date { Faker::Date.backward(days: 30) }
    project_id { 1 }
    status { Faker::Lorem.word }
    reporter_id { 1 }
    assigned_to_id { 1 }
    team_id { 1 }
  end
end
