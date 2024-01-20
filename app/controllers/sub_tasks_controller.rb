class SubTasksController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_project
  before_action :set_task
  before_action :set_task_sub_task, only: [:edit, :update, :destroy]

  def index
    @sub_tasks = @task.sub_tasks
  end

  def show
    @sub_task = SubTask.find(params[:id])
  end

  def new
    @sub_task = SubTask.new
  end

  def create
    @sub_task = SubTask.new(sub_task_params)

    if @sub_task.save
      redirect_to(company_project_task_sub_tasks_url(@company, @project, @task, @sub_task), notice: "Task was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
    if @sub_task.update(sub_task_params)
      redirect_to(company_project_task_sub_tasks_url(@company, @project, @task, @sub_task), notice: "Task was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @sub_task.destroy
    redirect_to(company_project_task_sub_tasks_url(@company, @project, @task), notice: "Task was successfully destroyed")
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_project
    @project = Project.friendly.find(params[:project_id])
  end

  def set_task
    @task = Task.friendly.find(params[:task_id])
  end

  def set_task_sub_task
    @task = Task.friendly.find(params[:task_id])
    @sub_task = @task.sub_tasks.find(params[:id])
  end

  def sub_task_params
    params.require(:sub_task).permit(:name, :description, :due_date, :project_id, :team_id, :reporter_id, :status, :assigned_to_id, :task_id)
  end
end
