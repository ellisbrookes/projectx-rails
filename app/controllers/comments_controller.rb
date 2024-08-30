class CommentsController < ApplicationController
  before_action :set_company
  before_action :set_team
  before_action :set_project
  before_action :set_task
  before_action :set_comment, only: %i[edit update destroy]

  layout 'dashboard'

  def new
    @comment = Comment.new
  end

  def create
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      CommentNotifier.with(
        comment_task: @comment.task.name,
        commenter_name: current_user.full_name,
        commenter_url: company_team_project_task_path(@company, @team, @project, @task),
      ).deliver(User.all)

      redirect_to(company_team_project_task_path(@company, @team, @project, @task), notice: "Comment was created successfully")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to(company_team_project_task_path(@company, @team, @project, @task), notice: "Comment was updated successfully")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @comment = @task.comments.find(params[:id])

    @comment.transaction do
      @comment.destroy
    end

    redirect_to(company_team_project_task_path(@company, @team, @project, @task), notice: "Comment was successfully destroyed")
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_team
    @team = Team.friendly.find(params[:team_id])
  end

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def set_task
    @task = Task.friendly.find(params[:task_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
