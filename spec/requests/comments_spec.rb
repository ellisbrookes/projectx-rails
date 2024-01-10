require 'rails_helper'

RSpec.describe("Comments", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    @team = FactoryBot.create(:team, company_id: @company.id)
    @project = FactoryBot.create(:project, company_id: @company.id, team_id: @team.id)
    @task = FactoryBot.create(:task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id)

    sign_in(@user)
  end

  describe "POST /tasks/new" do
    it "should be able to create a new comment using the inline form on the tasks show page" do
      get company_team_project_task_path(@company, @team, @project, @task)
      expect(response).to(render_template(:show))

      # create the comment
      comment_params = FactoryBot.attributes_for(:comment, user_id: @user.id, task_id: @task.id)
      post company_team_project_task_comments_path(task_id: @task), params: { comment: comment_params }

      # redirect to comment
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include("Comment was created successfully"))

      # testing task data
      expect(response.body).to(include(comment_params[:body]))
    end
  end

  describe "PUT /tasks/edit" do
    it "should be able to edit a comment using the edit button on the tasks show page" do
      @comment = FactoryBot.create(:comment, user_id: @user.id, task_id: @task.id)
      get company_team_project_task_path(@company, @team, @project, @task)

      # update the comment
      new_comment = Faker::Quote.jack_handey
      comment_params = { comment: { body: new_comment } }
      put company_team_project_task_comment_path(@company, @team, @project, @task, @comment)

      # redirect back to task
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the tasks show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_comment))
      expect(response.body).to(include("Comment was successfully updated"))
    end
  end

  describe "DELETE /tasks/show" do
    it "should be able to delete a comment using the delete comment button on the tasks show page" do
      @comment = FactoryBot.create(:comment, user_id: @user.id, task_id: @task.id)
      get company_team_project_task_path(@company, @team, @project, @task)

      # delete comment
      delete company_team_project_task_comment_path(@company, @team, @project, @task, @comment)

      # redirect to the comment
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # redirect to index page
      expect(response.body).to(include("Comment was successfully destroyed"))
    end
  end
end
