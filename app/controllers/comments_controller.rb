class CommentsController < ApplicationController
  before_action :set_task, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = @task.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to(@task, notice: "comment was created successfully")
    else
      redirect_to(@task, alert: "comment was not saved successfully")
    end
  end

  def destroy
    @comment = @task.comments.find(params[:id])
    @comment.destroy
    redirect_to(@task)
  end

  private

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
