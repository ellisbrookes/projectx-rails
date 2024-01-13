require 'rails_helper'

RSpec.describe("Teams", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    sign_in(@user)
  end

  describe "/index" do
    it "GET - should show that the team page has a title" do
      get company_teams_path(@company)

      # expect the index page to be successful
      expect(response).to(be_successful)
      expect(response.body).to(include("Teams"))
    end
  end

  describe "/new" do
    it "GET - should be able to render new teams page" do
      get new_company_team_path(@company)
      expect(response).to(render_template(:new))
    end

    it "POST - should be able to create a team" do
      get new_company_team_path(@company)
      expect(response).to(render_template(:new))

      # create the team
      team_params = FactoryBot.attributes_for(:team, company_id: @company.id)
      post company_teams_path(@company), params: { team: team_params }

      # redirect to the team
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Team was successfully created"))

      # testing team data
      expect(response.body).to(include(team_params[:name]))
      expect(response.body).to(include(team_params[:description]))
      expect(response.body).to(include(team_params[:email]))
    end

    it "POST - should not be able to create a team" do
      get new_company_team_path(@company)
      expect(response).to(render_template(:new))

      # create team without an email
      team_params = FactoryBot.attributes_for(:team, email: nil, company_id: @company.id)
      post company_teams_path(@company), params: { team: team_params }

      # render error message
      expect(response).to(have_http_status(:unprocessable_entity))

      # render team new page
      expect(response).to(render_template(:new))
      expect(response.body).to(include("Email can&#39;t be blank"))
    end
  end

  describe "/edit" do
    before do
      @team = FactoryBot.create(:team, company_id: @company.id)
    end

    it "GET - should be able to render the edit page" do
      get edit_company_team_path(@company, @team)
      expect(response).to(render_template(:edit))
    end

    it "PUT - should be able to update a team" do
      get edit_company_team_path(@company, @team)
      expect(response).to(render_template(:edit))

      # update email
      new_email = Faker::Internet.email
      team_params = { team: { email: new_email } }
      put company_team_path(@company), params: team_params

      # Redirect to team
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # Render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_email))
      expect(response.body).to(include("Team was successfully updated"))
    end

    it "PUT - should not be able to update a team" do
      get edit_company_team_path(@company, @team)
      expect(response).to(render_template(:edit))

      # update team without an email
      team_params = FactoryBot.attributes_for(:team, email: nil)
      put company_team_path(@company, @team), params: team_params

      # render error message
      expect(response).to(have_http_status(:unprocessable_entity))

      # render team edit page
      expect(response).to(render_template(:edit))
      expect(response.body).to(include("Email can&#39;t be blank"))
    end
  end

  describe "/delete" do
    before do
      @team = FactoryBot.create(:team, company_id: @company.id)
    end

    it "DELETE - should be able to delete a team" do
      get company_team_path(@company, @team)
      expect(response).to(render_template(:show))

      # delete company
      delete company_team_path(@company, @team)

      # redirect to company
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # redirect to index page
      expect(response).to(render_template(:index))
      expect(response.body).to(include("Team was successfully destroyed"))
    end
  end
end
