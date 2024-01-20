require 'rails_helper'

RSpec.describe("Tasks", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    @team = FactoryBot.create(:team, company_id: @company.id)
    @project = FactoryBot.create(:project, company_id: @company.id, team_id: @team.id)

    sign_in(@user)
  end

  describe "/index" do
    it "GET - should show that the task page has a title" do
      get company_team_project_tasks_path(@company, @team, @project)

      # expect the index page to be successful
      expect(response).to(be_successful)
      expect(response.body).to(include("Tasks"))
    end
  end

  describe "/new" do
    it "GET - should be able to render the new task page" do
      get new_company_team_project_task_path(@company, @team, @project)
      expect(response).to(render_template(:new))
    end

    it "POST - should be able to create a new task" do
      get new_company_team_project_task_path(@company, @team, @project)
      expect(response).to(render_template(:new))

      # create the task
      task_params = FactoryBot.attributes_for(:task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id)
      post company_team_project_tasks_path(@company, @team, @project), params: { task: task_params }

      task = Task.first

      # Redirect to task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # Render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Task was successfully created"))

      # Testing task data
      expect(response.body).to(include(task_params[:name]))
      expect(response.body).to(include(task_params[:description]))
      expect(response.body).to(include(task.due_date.strftime('%d/%m/%Y')))
      expect(response.body).to(include(task.project.title))
      expect(response.body).to(include(task_params[:status]))
      expect(response.body).to(include(task.reporter.full_name))
      expect(response.body).to(include(task.assigned_to.full_name))
      expect(response.body).to(include(task.team.name))
    end

    it "POST - should not be able to create a task" do
      get new_company_team_project_task_path(@company, @team, @project)
      expect(response).to(render_template(:new))

      # create a task without a name
      task_params = FactoryBot.attributes_for(:task, name: nil, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id)
      post company_team_project_tasks_path(@company, @team, @project), params: { task: task_params }

      # redirect back to task
      expect(response).to(have_http_status(:unprocessable_entity))

      # render error message
      expect(response).to(render_template(:new))
      expect(response.body).to(include("Name can&#39;t be blank"))
    end
  end

  describe "/edit" do
    before do
      @task = FactoryBot.create(:task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id)
    end

    it "GET - should be able to render the edit page of a task" do
      get edit_company_team_project_task_path(@company, @team, @project, @task)
      expect(response).to(render_template(:edit))
    end

    it "PUT - should be able to update a task" do
      get edit_company_team_project_task_path(@company, @team, @project, @task)
      expect(response).to(render_template(:edit))

      # update name
      new_name = Faker::Company.name.gsub(/[^0-9a-zA-Z\s]/, '')
      task_params = { task: { name: new_name } }
      put company_team_project_task_path(@company, @team, @project, @task), params: task_params

      # redirect to task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_name))
      expect(response.body).to(include("Task was successfully updated"))
    end

    it "PUT - should not be able to update a task" do
      get edit_company_team_project_task_path(@company, @team, @project, @task)
      expect(response).to(render_template(:edit))

      # update name
      task_params = { task: { name: nil } }
      put company_team_project_task_path(@company, @team, @project, @task), params: task_params

      # redirect to task
      expect(response).to(have_http_status(:unprocessable_entity))

      # render the edit page
      expect(response).to(render_template(:edit))
      expect(response.body).to(include("Name can&#39;t be blank"))
    end
  end

  describe "/delete" do
    before do
      @task = FactoryBot.create(:task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id)
    end

    it "DELETE - should be able to delete a task" do
      get company_team_project_task_path(@company, @team, @project, @task)
      expect(response).to(render_template(:show))

      # delete task
      delete company_team_project_task_path(@company, @team, @project, @task)

      # redirect to task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # redirect to the index page
      expect(response).to(render_template(:index))
      expect(response.body).to(include("Task was successfully destroyed"))
    end
  end
end
