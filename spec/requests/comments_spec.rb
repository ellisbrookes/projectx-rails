require 'rails_helper'
require 'cgi'

RSpec.describe("Comments", type: :request) do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company, user_id: @user.id)
    @team = FactoryBot.create(:team, company_id: @company.id)
    @project = FactoryBot.create(:project, company_id: @company.id, team_id: @team.id)
    @task = FactoryBot.create(:task, reporter_id: @user.id, assigned_to_id: @user.id, team_id: @team.id, project_id: @project.id)

    sign_in(@user)
  end

  describe "/new" do
    it "POST - should be able to create a new comment for a task" do
      get new_company_team_project_task_comment_path(@company, @team, @project, @task)
      expect(response).to(render_template(:new))

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
      expect(response.body).to(match(comment_params[:body]))
    end
  end

  describe "inline tasks /new" do
    before do
      get company_team_project_task_path(@company, @team, @project, @task)
      expect(response).to(render_template(:show))
    end

    it "POST - should be able to create a new comment using the inline form on the tasks show page" do
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
      expect(response.body).to(match(comment_params[:body]))
    end

    it "POST - should not be able to create a new comment using the inline form on the tasks show page" do
      # create the comment
      comment_params = FactoryBot.attributes_for(:comment, body: "", user_id: @user.id, task_id: @task.id)
      post company_team_project_task_comments_path(task_id: @task), params: { comment: comment_params }

      # redirect to comment
      expect(response).to(have_http_status(:unprocessable_entity))

      # render the show page
      expect(response).to(render_template(:new))
      expect(response.body).to(include("Body can&#39;t be blank"))
    end
  end

  describe "/edit" do
    it "PUT - should be able to edit a comment using /tasks/comment/:id/edit page" do
      @comment = FactoryBot.create(:comment, user_id: @user.id, task_id: @task.id)
      get edit_company_team_project_task_comment_path(@company, @team, @project, @task, @comment)

      # update the comment
      new_comment = CGI.unescapeHTML(Faker::Lorem.sentence(word_count: 20).gsub(/[^0-9a-zA-Z\s]/, ''))
      comment_params = { comment: { body: new_comment } }
      put company_team_project_task_comment_path(@company, @team, @project, @task, @comment), params: comment_params

      # redirect back to comment
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the tasks show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_comment))
      expect(response.body).to(include("Comment was updated successfully"))
    end
  end

  describe "iinline tasks /edit" do
    before do
      @comment = FactoryBot.create(:comment, user_id: @user.id, task_id: @task.id)
      get company_team_project_task_path(@company, @team, @project, @task)
    end

    it "PUT - should be able to edit a comment using the edit button on the tasks show page" do
      # update the comment
      new_comment = CGI.unescapeHTML(Faker::Lorem.sentence(word_count: 20).gsub(/[^0-9a-zA-Z\s]/, ''))
      comment_params = { comment: { body: new_comment } }
      put company_team_project_task_comment_path(@company, @team, @project, @task, @comment), params: comment_params

      # redirect back to comment
      expect(response).to(have_http_status(:redirect))
      follow_redirect!

      # render the tasks show page
      expect(response).to(render_template(:show))
      expect(response.body).to(include(new_comment))
      expect(response.body).to(include("Comment was updated successfully"))
    end

    it "PUT - should not be able to create a new comment using the inline form on the tasks show page" do
      # update the comment
      comment_params = { comment: { body: "" } }
      put company_team_project_task_comment_path(@company, @team, @project, @task, @comment), params: comment_params

      # redirect to comment
      expect(response).to(have_http_status(:unprocessable_entity))

      # render the show page
      expect(response).to(render_template(:edit))
      expect(response.body).to(include("Body can&#39;t be blank"))
    end
  end

  describe "inline tasks /delete" do
    it "DELETE - should be able to delete a comment using the delete comment button on the tasks show page" do
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
