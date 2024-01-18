require 'rails_helper'

RSpec.describe("Dashboards", type: :request) do
  describe "GET /index" do
    before do
      @user = FactoryBot.create(:user)
      sign_in(@user)
    end

    it "should show that the dashboard has a title" do
      get dashboard_index_path

      expect(response).to(be_successful)
      expect(response.body).to(include("ProjectxRails"))
    end
  end
end
