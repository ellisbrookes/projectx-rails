class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_company_team, only: %i[edit update destroy]

  layout 'dashboard'

  def index
    @teams = @company.teams
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
    @team.team_members.build
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to(company_team_url(@company, @team), notice: "Team was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
    @team.team_members.build
  end

  def update
    if @team.update(team_params)
      redirect_to(company_team_url(@company, @team), notice: "Team was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @team.destroy
    redirect_to(company_teams_url(@company), notice: "Team was successfully destroyed")
  end

  private

  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_company_team
    @company = Company.find(params[:company_id])
    @team = @company.teams.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :description, :email, :company_id, team_members_attributes: [:id, :user_id])
  end
end
