class TasksController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_project
  before_action :set_project_task, only: [:edit, :update, :destroy]

  def index
    @tasks = @project.tasks
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Project.tasks.build
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to(company_project_task_url(@company, @project, @task), notice: "Task was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to(company_project_task_url(@company, @project, @task), notice: "Task was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @task.destroy
    redirect_to(company_project_tasks_url(@company, @project), notice: "Task was successfully destroyed")
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_task
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :project_id, :team_id, :reporter_id, :status, :assigned_to_id)
  end
end
