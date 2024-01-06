require 'rails_helper'

RSpec.describe("Tasks", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    @project = FactoryBot.create(:project, company: @company)
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
      expect(response).to(render(:new))

      # create the task
      task_params = FactoryBot.attributes_for(:task, team_members_attributes: [{ user_id: @user.id }], company_id: @company.id, project_id: @project.id)
      post company_project_task_path(company_id: @company.id, project_id: @project.id)

      # Redirect to task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # Render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Task was successfully created."))

      # Testing task data
      expect(response.body).to(include(task_params[:name]))
      expect(response.body).to(include(task_params[:description]))
      expect(response.body).to(include(task_params[:due_date]))
      expect(response.body).to(include(task_params[:project_id]))
      expect(response.body).to(include(task_params[:status]))
      expect(response.body).to(include(task_params[:reporter_id]))
      expect(response.body).to(include(task_params[:assigned_to_id]))
      expect(response.body).to(include(task_params[:team_id]))
    end

    it "should not be able to create a task" do
      get new_company_project_task_path(company_id: @company.id, project_id: @project.id)
      expect(response).to(render_template(:new))

      # create a task without a name
      FactoryBot.attributes_for(:task, name: "", team_members_attributes: [{ user_id: @user.id }], company_id: @company.id, project_id: @project.id)
      post company_project_task_path(company_id: @company.id, project_id: @project.id)

      # render error message
      expect(response).to(render_template(:new))

      # render error message saying task name can't be blank
      expect(response.body).to(include("Task name can&#39;t be blank"))
    end
  end
end
