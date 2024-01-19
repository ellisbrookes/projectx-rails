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
      get company_team_projects_path(@company, @team)

      # expect the index page to include the word projects
      expect(response).to(be_successful)
      expect(response.body).to(include("Projects"))
    end
  end

  describe "/new" do
    it "GET - should be able to render the new projects page" do
      get new_company_team_project_path(@company, @team)
      expect(response).to(render_template(:new))
    end

    it "POST - should be able to create a new project" do
      get new_company_team_project_path(@company, @team)
      expect(response).to(render_template(:new))

      # create a new project
      project_params = FactoryBot.attributes_for(:project, company_id: @company.id, team_id: @team.id)
      post company_team_projects_path(@company, @team), params: { project: project_params }

      # redirect to project
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # rrnder the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Project was successfully created"))

      # testing project data
      expect(response.body).to(include(project_params[:title]))
      expect(response.body).to(include(project_params[:description]))
    end

    it "POST - should not be able to create a new project" do
      get new_company_team_project_path(@company, @team)
      expect(response).to(render_template(:new))

      # create a new project
      project_params = FactoryBot.attributes_for(:project, title: nil, company_id: @company.id, team_id: @team.id)
      post company_team_projects_path(@company, @team), params: { project: project_params }

      # redirect to project
      expect(response).to(have_http_status(:unprocessable_entity))

      # render team new page
      expect(response).to(render_template(:new))
      expect(response.body).to(include("Title can&#39;t be blank"))
    end
  end

  describe "/edit" do
    before do
      @project = FactoryBot.create(:project, company_id: @company.id, team_id: @team.id)
    end

    it "GET - should be able to render the edit page" do
      get edit_company_team_project_path(@company, @team, @project)
      expect(response).to(render_template(:edit))
    end

    it "PUT - should be able to update a project" do
      get edit_company_team_project_path(@company, @team, @project)
      expect(response).to(render_template(:edit))

      # update title
      new_title = Faker::Company.name.gsub(/[^0-9a-zA-Z\s]/, '')
      project_params = { project: { title: new_title } }
      put company_team_project_path(@company, @team, @project), params: project_params

      # Redirect to team
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # Render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_title))
      expect(response.body).to(include("Project was successfully updated"))
    end

    it "PUT - should not be able to update a project" do
      get edit_company_team_project_path(@company, @team, @project)
      expect(response).to(render_template(:edit))

      # update project without a title
      project_params = { project: { title: nil } }
      put company_team_project_path(@company, @team, @project), params: project_params

      # render error message
      expect(response).to(have_http_status(:unprocessable_entity))

      # render the edit page
      expect(response).to(render_template(:edit))
      expect(response.body).to(include("Title can&#39;t be blank"))
    end
  end

  describe "/delete" do
    before do
      @project = FactoryBot.create(:project, company_id: @company.id, team_id: @team.id)
    end

    it "DELETE - should be able to delete a project" do
      get company_team_project_path(@company, @team, @project)
      expect(response).to(render_template(:show))

      # delete a project
      delete company_team_project_path(@company, @team, @project)

      # redirect to porjects
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # redirect to the porjects index page
      expect(response).to(render_template(:index))
      expect(response.body).to(include("Project was successfully destroyed"))
    end
  end
end
