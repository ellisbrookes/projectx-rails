require 'rails_helper'

RSpec.describe("Projects", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    @team = FactoryBot.create(:team, company_id: @company.id)

    sign_in(@user)
  end

  describe "/index" do
    it "GET - should show that the project page has a title" do
      get new_company_team_projects_path(@company, @team)

      # expect the index page to include the word projects
      expect(response).to(be_successful)
      expect(response.body).to(include("Projects"))
    end
  end

  describe "/new" do
    it "GET - should be able to render the new projects page" do
      get new_company_team_projects_path(@company, @team)

      # expect the index page to be successful
      expect(response).to(be_successful)
      expect(response.body).to(include("Projects"))
    end

    it "POST - should be able to create a new project" do
      get new_company_team_project_path(@company, @team)
      expect(response).to(render_template(:new))

      # create the project
      project_params = FactoryBot.attributes_for(:project, company_id: @company.id, team_id: @team.id)
      post company_team_projects_path(@company, @team), params: { project: project_params }
      debugger

      # redirect to project
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Project was successfully created"))

      # testing project data
      expect(response.body).to(include(project_params[:title]))
      expect(response.body).to(include(project_params[:description]))
    end
  end
end