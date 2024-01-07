require 'rails_helper'

RSpec.describe("Tasks", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    @team = FactoryBot.create(:team, company: @company)
    @project = FactoryBot.create(:project, company: @company, team: @team)
    sign_in(@user)
  end

  describe "GET /index" do
    it "should show that the task page has a title" do
      get company_project_tasks_path(company_id: @company.id, project_id: @project.id)

      # expect the index page to be successful
      expect(response).to(be_successful)
      expect(response.body).to(include("Tasks"))
    end
  end

  describe "GET /dashboard/companies/:id/projects/:id/tasks/new" do
    it "Should be able to render the new task page" do
      get new_company_project_task_path(company_id: @company.id, project_id: @project.id)
      expect(response).to(render_template(:new))
    end

    it "should be able to create a new task" do
      get new_company_project_task_path(company_id: @company.id, project_id: @project.id)
      expect(response).to(render_template(:new))

      # create the task
      task_params = FactoryBot.attributes_for(:task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, company_id: @company.id, project_id: @project.id)
      post company_project_tasks_path(@company, @project), params: { task: task_params }

      task = Task.first
      
      # Redirect to task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # Render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Task was successfully created."))

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

    it "should not be able to create a task" do
      get new_company_project_task_path(company_id: @company.id, project_id: @project.id)
      expect(response).to(render_template(:new))

      # create a task without a name
      task_params = FactoryBot.attributes_for(:task, name: "", reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, company_id: @company.id, project_id: @project.id)
      post company_project_tasks_path(@company, @project), params: { task: task_params }

      # render error message
      expect(response).to(render_template(:new))

      # render error message saying name can't be blank
      expect(response.body).to(include("Name can&#39;t be blank<"))
    end
  end

  describe "PUT /edit" do
    before do
      get new_company_project_task_path(company_id: @company.id, project_id: @project.id)
      expect(response).to(render_template(:new))

      # create the task
      task_params = FactoryBot.attributes_for(:task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, company_id: @company.id, project_id: @project.id)
      post company_project_tasks_path(@company, @project), params: { task: task_params }

      # redirect to the task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!
    end

    it "Should be able to update a task" do
      @task = Task.first
      get edit_company_project_task_path(company_id: @company.id, project_id: @project.id, task_id: @task.id)
      expect(response).to(render_template(:edit))

      # update name
      new_name = Faker::Company.name
      debugger
      task_params = { task: { task_name: new_name } }
      put company_project_task_path(@company, @project, @task), params: task_params

      # redirect to the task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_name))
      expect(response.body).to(include("Task was successfully updated."))
    end

    xit "Should not be able to update a task" do
      @task = Task.first
      get edit_company_project_task_path(company_id: @company.id, project_id: @project.id)
      expect(response).to(render_template(:edit))

      # update task without a name
      task_params = FactoryBot.attributes_for(:task, name: "", team_members_attributes: [{ user_id: @user.id }], company_id: @company.id, project_id: @project.id)
      put company_project_task_path(company_id: @company.id, project_id: @project.id), params: task_params

      # render error message
      expect(response).to(render_template(:unprocessable_entity))

      # render task edit page
      expect(response).to(render_template(:edit))

      # render error message saying name can't be blank
      expect(response.body).to(include("Task name can&#39;t be blank"))
    end
  end

  # describe "DELETE /show" do
  #   it "Should be able to delete a task"
  #   @task = FactoryBot.create(:task, project_id: @project.id, team_id: @team.id)

  #   get company_project_task_path(company_id: @company.id, project_id: @project.id)
  #   expect(response).to(render_template(:show))

  #   # delete task
  #   delete company_project_task_path(company_id: @company.id, project_id: @project.id)

  #   # redirect to task
  #   expect(response).to(have_http_status(:redirect))
  #   follow_redirect!

  #   # redirect to the index page
  #   expect(response).to(render_template(:index))
  #   expect(response.body).to(include("Task was successfully destroyed."))
  # end
end
