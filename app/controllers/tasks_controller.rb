class TasksController < ApplicationController
  layout 'dashboard'
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(project_params)

    if @task.save
      redirect_to(task_url(@task), notice: "Task was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to(task_url(@task), notice: "Task was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @task.destroy

    redirect_to(tasks_url, notice: "Task was successfully destroyed")
  end

  private

  def set_task
    @task = Task.find(params[:name])
  end

  def task_params
    params.require(:task).permit(:name, :description, :start_date, :completion_date, :assigned_to :status [:id, :user_id] :project)
  end
end
