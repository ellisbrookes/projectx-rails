FactoryBot.define do
  factory :default_role do
    name { "default" }
  end

  factory :admin_role do
    name { "admin" }
  end

  factory :super_admin_role do
    name {"superadmin"}
  end
end
