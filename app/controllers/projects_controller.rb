class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy]

  layout 'dashboard'

  def index
    @projects = Projects.all
  end

  def show
  end

  def new
    @project = project.new
    @project.project.build
  end

  def create
    @projects = Project.new(team_params)

    if @project.save
      redirect_to(projects_url(@project), notice: "Project was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
    @project.project.build
  end

  def update
    if @project.update(project_params)
      redirect_to(project_url(@team), notice: "Project was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @project.destroy

    redirect_to(projects_url, notice: "Project was successfully destroyed")
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
