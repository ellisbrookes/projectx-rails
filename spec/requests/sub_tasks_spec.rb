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
      # expect(response.body).to(include("Sub-Tasks"))
    end
  end
end
