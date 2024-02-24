FactoryBot.define do
  factory :default_role do
    name { "default" }
  end

  factory :admin_role do
    name { "admin" }
  end
end
