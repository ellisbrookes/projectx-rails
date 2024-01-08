require 'rails_helper'

RSpec.describe("Comments", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    @team = FactoryBot.create(:team, company: @company)
    @project = FactoryBot.create(:project, company: @company, team: @team)
    sign_in(@user)
  end

  xit "should be able to create a new comment" do
    get company_team_project_task_comments_path(@company, @team, @project, @task, @comments)
    expect(response).to(render_template(:new))

    # create the comment
    comment_params = FactoryBot.attributes_for(:comment, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, company_id: @company.id, project_id: @project.id, task_id: @task.id)
    post company_team_project_task_comments_path(@company, @team, @project, @task, @comments), params: { comment: comment_params }
    task = Task.first

    # Redirect to task
    expect(response).to(have_http_status(:redirect))
    follow_redirect!

    # Render the show page
    expect(response).to(render_template(:show))
    expect(response.body).to(include("Comment was successfully created."))

    # Testing task data
    expect(response.body).to(include(comment_params[:body]))
  end
end