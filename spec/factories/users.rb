FactoryBot.define do sequence "email" do |n| "person#{n}@example.com" end
factory :user do full_name { "John Doe" } email password { "testing1234" }
confirmed_at { Time.now } is_admin { false } end factory :admin do full_name {
"John Admin" } email password { "admin1234" } confirmed_at { Time.now } is_admin
{ true } end end
