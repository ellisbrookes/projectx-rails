require 'rails_helper'

RSpec.describe("Projects", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    @team = FactoryBot.create(:team, company_id: @company.id)

    sign_in(@user)
  end

  describe "GET /index" do
    it "should show that the project page has a title" do
      get company_team_projects_path(@company, @team)

      # expect the index page to include the word projects
      expect(response).to(be_successful)
      expect(response.body).to(include("Projects"))
    end
  end
end