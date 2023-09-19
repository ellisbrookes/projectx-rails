require 'rails_helper' RSpec.describe(User, type: :model) do it "should not
validate users without an email" do @user = FactoryBot.build(:user, email:
"not_an_email") expect(@user).to_not(be_valid) end end
