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
      expect(response.body).to(include(team_params[:team_email]))
      # expect(response.body).to(include(company_params[:company_id]))
    end
  end

  #   it "should not be able to create a company" do
  #     get new_company_path
  #     expect(response).to(render_template(:new))

  #     # create company without an email
  #     company_params = FactoryBot.attributes_for(:company, email: "")
  #     post companies_path, params: { company: company_params }

  #     # render error message
  #     expect(response).to(have_http_status(:unprocessable_entity))

  #     # render company new page
  #     expect(response).to(render_template(:new))

  #     # render error message saying email can't be blank
  #     expect(response.body).to(include("Email can&#39;t be blank"))
  #   end
  # end

  # describe "PUT /edit" do
  #   before do
  #     @company = FactoryBot.create(:company, user_id: @user.id)
  #   end

  #   it "Should be able to update a company" do
  #     get edit_company_path(@company)
  #     expect(response).to(render_template(:edit))

  #     # update email
  #     new_email = Faker::Internet.email
  #     company_params = { company: { email: new_email } }
  #     put company_path(@company), params: company_params

  #     # Redirect to company
  #     expect(response).to(have_http_status(:redirect))
  #     follow_redirect!

  #     # Render the show page
  #     expect(response).to(render_template(:show))
  #     expect(response.body).to(include(new_email))
  #     expect(response.body).to(include("Company was successfully updated."))
  #   end

  #   it "should not be able to update a company" do
  #     get edit_company_path(@company)
  #     expect(response).to(render_template(:edit))

  #     # update company without an email
  #     company_params = FactoryBot.attributes_for(:company, email: "")
  #     put company_path(@company), params: { company: company_params }

  #     # render error message
  #     expect(response).to(have_http_status(:unprocessable_entity))

  #     # render company edit page
  #     expect(response).to(render_template(:edit))

  #     # render error message saying email can't be blank
  #     expect(response.body).to(include("Email can&#39;t be blank"))
  #   end
  # end

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
