require 'rails_helper'

RSpec.describe("Teams", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    sign_in(@user)
  end

  describe "GET /dashboard/companies/:id/teams" do
    it "should show that the team page has a title" do
      get company_teams_path(company_id: @company.id)

      # expect the index page to include the word teams
      expect(response).to(be_successful)
      expect(response.body).to(include("Teams"))
    end
  end

  describe "GET /dashboard/companies/:id/teams/new" do
    it "Should be able to render new teams page" do
      get new_company_team_path(company_id: @company.id)
      expect(response).to(render_template(:new))
    end

    it "Should be able to create a team" do
      get new_company_team_path(company_id: @company.id)
      expect(response).to(render_template(:new))

      # Create the team
      team_params = FactoryBot.attributes_for(:team, team_members_attributes: [{ user_id: @user.id }], company_id: @company.id, user_id: @user.id)
      post company_teams_path, params: { company: @company, team: team_params }

      # Redirect to the team
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # Render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Team was successfully created."))

      # Testing team data
      expect(response.body).to(include(team_params[:name]))
      expect(response.body).to(include(team_params[:description]))
      expect(response.body).to(include(team_params[:email]))
    end

    it "should not be able to create a team" do
      get new_company_team_path(company_id: @company.id)
      expect(response).to(render_template(:new))

      # create team without an email
      team_params = FactoryBot.attributes_for(:team, email: "", team_members_attributes: [{ user_id: @user.id }], company_id: @company.id, user_id: @user.id)

      post company_teams_path, params: { company: @company, team: team_params }

      # render error message
      expect(response).to(have_http_status(:unprocessable_entity))

      # render team new page
      expect(response).to(render_template(:new))

      # render error message saying team email can't be blank
      expect(response.body).to(include("Email can&#39;t be blank"))
    end
  end

  describe "PUT /edit" do
    before do
      # @team = FactoryBot.create(:team, team_members_attributes: [{ user_id: @user.id }], company_id: @company.id, user_id: @user.id)

      get new_company_team_path(company_id: @company.id)
      expect(response).to(render_template(:new))

      # Create the team
      team_params = FactoryBot.attributes_for(:team, team_members_attributes: [{ user_id: @user.id }], company_id: @company.id, user_id: @user.id)
      post company_teams_path, params: { company: @company, team: team_params }

      # Redirect to the team
      expect(response).to(have_http_status(:redirect))
      follow_redirect!
    end

    it "Should be able to update a team" do
      @team = Team.first
      get edit_company_team_path(company_id: @company.id, team_id: @team.id)
      expect(response).to(render_template(:edit))

      # update email
      new_email = Faker::Internet.email
      team_params = { team: { email: new_email } }
      put company_team_path(@company, @team), params: team_params

      # Redirect to team
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # Render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_email))
      expect(response.body).to(include("Team was successfully updated."))
    end

    it "should not be able to update a team" do
      @team = Team.first
      get edit_company_team_path(company_id: @company.id, team_id: @team.id)
      expect(response).to(render_template(:edit))

      # update team without an email 
      team_params = FactoryBot.attributes_for(:team, email: "", team_members_attributes: [{ user_id: @user.id }], company_id: @company.id, user_id: @user.id)
      put company_team_path(@company, @team), params: team_params

      # render error message
      expect(response).to(have_http_status(:unprocessable_entity))

      # render team edit page
      expect(response).to(render_template(:edit))

      # render error message saying email can't be blank
      expect(response.body).to(include("Email can&#39;t be blank"))
    end
  end

  # describe "DELETE /show" do
  #   it "Should be able to delete a company" do
  #     @company = FactoryBot.create(:company, user_id: @user.id)
  #     get company_path(@company)
  #     expect(response).to(render_template(:show))

  #     # delete company
  #     delete company_path(@company)

  #     # redirect to company
  #     expect(response).to(have_http_status(:redirect))
  #     follow_redirect!

  #     # redirect to index page
  #     expect(response).to(render_template(:index))
  #     expect(response.body).to(include("Company was successfully destroyed."))
  #   end
  # end
end
