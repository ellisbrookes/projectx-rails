class ProjectsController < ApplicationController
  layout 'dashboard'

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to(project_url(@project), notice: "Project was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to(project_url(@project), notice: "Project was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @project.destroy

    redirect_to(project_url, notice: "Project was successfully destroyed")
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :estimated_completion_date, :completion_date, team_attributes: [:team_id], company_attributes: [:company_id])
  end
end
