class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_team
  before_action :set_project
  before_action :set_task, only: %i[show edit update destroy]

  layout 'dashboard'

  grant_access

  def index
    @tasks = @project.tasks
    add_breadcrumbs("Tasks", company_team_project_tasks_path)
  end

  def show
    @comments = @task.comments.order(created_at: :desc)
    @pagy, @comments = pagy(@comments, items: 5)
    add_breadcrumbs("Tasks", company_team_project_tasks_path)
    add_breadcrumbs(@task.name)
  end

  def new
    @task = Task.new
  end

  def create
    @task = @project.tasks.build(task_params)
    # @task = Task.new(task_params)

    if @task.save
      redirect_to(company_team_project_task_path(@company, @team, @project, @task), notice: "Task was successfully created")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
    add_breadcrumbs("Tasks", company_team_project_tasks_path)
    add_breadcrumbs("Edit")
    add_breadcrumbs(@task.name, company_team_project_task_path)
  end

  def update
    if @task.update(task_params)
      redirect_to(company_team_project_task_path(@company, @team, @project, @task), notice: "Task was successfully updated")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @task.destroy
    redirect_to(company_team_project_tasks_path(@company, @team, @project), notice: "Task was successfully destroyed")
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
    @task = Task.friendly.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :due_date, :project_id, :team_id, :reporter_id, :status, :assigned_to_id)
  end
end
