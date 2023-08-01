class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: %i[ show edit update destroy]

  layout 'dashboard'

  def index
    @teams = Team.all
  end

  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to team_url(@team), notice: "Team was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to team_url(@team), notice: "Team was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
    
    redirect_to teams_url, notice: "Team was successfully destroyed"
  end

  private

    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :description, :team_email, :company_id, team_members_ids: [])
    end
end