class SubTasksController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @sub_tasks = Sub_Task.all
  end

  def show
  end

  def new
    @sub_task = Sub_Task.new
  end

  def create
    @task = Sub_Task.new(task_params)

    if @sub_task.save
      redirect_to(task_url(@sub_task), notice: "Task was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
    if @sub_task.update(task_params)
      redirect_to(sub_task_url(@sub_task), notice: "Task was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @sub_task.destroy

    redirect_to(sub_tasks_url, notice: "Task was successfully destroyed")
  end

  private

  def set_sub_task
    @task = Sub_Task.find(params[:id])
  end

  def sub_task_params
    params.require(:sub_task).permit(:name, :description, :due_date, :project_id, :team_id, :reporter_id, :status, :assigned_to_id)
  end
end