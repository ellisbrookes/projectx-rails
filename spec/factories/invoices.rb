FactoryBot.define do
  factory :invoice do
    invoice_number { "MyString" }
    client_name { "MyString" }
    issue_date { "2024-01-24" }
    due_date { "2024-01-24" }
    amount { "9.99" }
    project { nil }
  end
end
