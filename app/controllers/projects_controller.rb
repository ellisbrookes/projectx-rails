class ProjectsController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_company_project, only: [:edit, :update, :destroy]

  def index
    @projects = @company.projects
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to(company_project_url(@company, @project), notice: "Project was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to(company_project_url(@company, @project), notice: "Project was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @project.destroy
    redirect_to(company_projects_url(@company), notice: "Project was successfully destroyed")
  end
  
  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_company_project
    @company = Company.find(params[:company_id])
    @project = @company.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:id, :title, :description, :start_date, :completion_date, :estimated_budget, :actual_budget, :team_id, :company_id)
  end
end
