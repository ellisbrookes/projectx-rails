class CommentsController < ApplicationController
  before_action :set_company
  before_action :set_team
  before_action :set_project
  before_action :set_task
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to(company_team_project_task_path(@company, @team, @project, @task), notice: "comment was created successfully")
    else
      redirect_to(company_team_project_task_path(@company, @team, @project, @task), alert: "comment was not saved successfully")
    end
  end

  def destroy
    @comment = @task.comments.find(params[:id])

    @comment.transaction do
      @comment.destroy
    end

    redirect_to(company_team_project_task_path(@company, @team, @project, @task), notice: "comment was successfully destroyed")
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
