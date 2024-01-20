require 'rails_helper'

RSpec.describe("SubTasks", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    @team = FactoryBot.create(:team, company_id: @company.id)
    @project = FactoryBot.create(:project, company_id: @company.id, team_id: @team.id)
    @task = FactoryBot.create(:task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id)

    sign_in(@user)
  end

  describe "/index" do
    it "GET - should show that the sub_task page has a title" do
      get company_team_project_task_sub_tasks_path(@company, @team, @project, @task)

      # expect the index page to be successful
      expect(response).to(be_successful)
      expect(response.body).to(include("Sub Tasks"))
    end
  end

  describe "/new" do
    it "GET - should be able to render the new sub task page" do
      get new_company_team_project_task_sub_task_path(@company, @team, @project, @task)
      expect(response).to(render_template(:new))
    end

    it "POST - should be able to create a new sub task" do
      get new_company_team_project_task_sub_task_path(@company, @team, @project, @task)
      expect(response).to(render_template(:new))

      # create the sub task
      sub_task_params = FactoryBot.attributes_for(:sub_task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id, task_id: @task.id)
      post company_team_project_task_sub_tasks_path(@company, @team, @project, @task), params: { sub_task: sub_task_params }

      sub_task = SubTask.first

      # redirect to the sub task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Sub task was successfully created"))

      # testing sub task data
      expect(response.body).to(include(sub_task_params[:name]))
      expect(response.body).to(include(sub_task_params[:description]))
      expect(response.body).to(include(sub_task.due_date.strftime('%d/%m/%Y')))
      expect(response.body).to(include(sub_task.project.title))
      expect(response.body).to(include(sub_task_params[:status]))
      expect(response.body).to(include(sub_task.assigned_to.full_name))
      expect(response.body).to(include(sub_task.reporter.full_name))
      expect(response.body).to(include(sub_task.team.name))
    end

    it "POST - should not be able to create a sub task" do
      get new_company_team_project_task_sub_task_path(@company, @team, @project, @task)
      expect(response).to(render_template(:new))

      # create a sub task without a name
      sub_task_params = FactoryBot.attributes_for(:sub_task, name: nil, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id, task_id: @task.id)
      post company_team_project_task_sub_tasks_path(@company, @team, @project, @task), params: { sub_task: sub_task_params }

      # redirect back to sub task
      expect(response).to(have_http_status(:unprocessable_entity))

      # render error message
      expect(response).to(render_template(:new))
      expect(response.body).to(include("Name can&#39;t be blank"))
    end
  end

  describe "/edit" do
    before do
      @sub_task = FactoryBot.create(:sub_task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id, task_id: @task.id)
    end

    it "GET - should be able to render the edit page of a sub task" do
      get edit_company_team_project_task_sub_task_path(@company, @team, @project, @task, @sub_task)
      expect(response).to(render_template(:edit))
    end

    it "PUT - should be able to update a sub task" do
      get edit_company_team_project_task_sub_task_path(@company, @team, @project, @task, @sub_task)
      expect(response).to(render_template(:edit))

      # update name
      new_name = Faker::Company.name.gsub(/[^0-9a-zA-Z\s]/, '')
      sub_task_params = { sub_task: { name: new_name } }
      put company_team_project_task_sub_task_path(@company, @team, @project, @task, @sub_task), params: sub_task_params

      # redirect to the sub task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_name))
      expect(response.body).to(include("Sub task was successfully updated"))
    end

    it "PUT - should not be able to update a task" do
      get edit_company_team_project_task_sub_task_path(@company, @team, @project, @task, @sub_task)
      expect(response).to(render_template(:edit))

      # update name
      sub_task_params = { sub_task: { name: nil } }
      put company_team_project_task_sub_task_path(@company, @team, @project, @task, @sub_task), params: sub_task_params

      # redirect to the sub task
      expect(response).to(have_http_status(:unprocessable_entity))

      # render the edit page
      expect(response).to(render_template(:edit))
      expect(response.body).to(include("Name can&#39;t be blank"))
    end
  end

  describe "/delete" do
    before do
      @sub_task = FactoryBot.create(:sub_task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id, task_id: @task.id)
    end

    it "DELETE - should be able to delete a sub task" do
      get company_team_project_task_sub_task_path(@company, @team, @project, @task, @sub_task)
      expect(response).to(render_template(:show))

      # delete the sub task
      delete company_team_project_task_sub_task_path(@company, @team, @project, @task, @sub_task)

      # redirect to sub task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # redirect to the index page
      expect(response).to(render_template(:index))
      expect(response.body).to(include("Sub task was successfully destroyed"))
    end
  end
end
