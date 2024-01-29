class SubTasksController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_team
  before_action :set_project
  before_action :set_task
  before_action :set_sub_task, only: %i[show edit update destroy]

  def index
    @sub_tasks = @task.sub_tasks
    add_breadcrumbs("Sub Tasks", company_team_project_task_sub_tasks_path)
  end

  def show
    add_breadcrumbs("Sub Tasks", company_team_project_task_sub_tasks_path)
    add_breadcrumbs(@sub_task.name, company_team_project_task_sub_tasks_path)
  end

  def new
    @sub_task = SubTask.new
  end

  def create
    @sub_task = SubTask.new(sub_task_params)

    if @sub_task.save
      redirect_to(company_team_project_task_sub_task_url(@company, @team, @project, @task, @sub_task), notice: "Sub task was successfully created")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
    add_breadcrumbs("Sub Tasks", company_team_project_task_sub_tasks_path)
    add_breadcrumbs("Edit", edit_company_team_project_task_sub_tasks_path)
    add_breadcrumbs(@sub_task.name, company_team_project_task_sub_task_path)
  end

  def update
    if @sub_task.update(sub_task_params)
      redirect_to(company_team_project_task_sub_task_url(@company, @team, @project, @task, @sub_task), notice: "Sub task was successfully updated")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @sub_task.destroy
    redirect_to(company_team_project_task_sub_tasks_url(@company, @team, @project, @task), notice: "Sub task was successfully destroyed")
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

  def set_sub_task
    @sub_task = SubTask.friendly.find(params[:id])
  end

  def sub_task_params
    params.require(:sub_task).permit(:name, :description, :due_date, :project_id, :team_id, :reporter_id, :status, :assigned_to_id, :task_id)
  end
end
