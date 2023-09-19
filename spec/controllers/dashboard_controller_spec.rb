require 'rails_helper' RSpec.describe("DashboardController", type: :controller)
do before do @user = FactoryBot.create(:user) sign_in(@user) end describe "GET
/index" do context "User is logged in" do before do it "loads the correct user
details" do expect(response).to(have_http_status(200))
expect(assign(:user)).to(eq(@user)) end end end end end
