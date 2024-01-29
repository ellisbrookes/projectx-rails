class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: %i[show edit update destroy]

  layout 'dashboard'

  def index
    @companies = Company.where(user_id: current_user)
    add_breadcrumbs("Companies", companies_path)
  end

  def show
    @teams = Team.where(company_id: @company.id)
    add_breadcrumbs("Companies", companies_path)
    add_breadcrumbs(@company.name, companies_path)
  end

  def new
    @company = Company.new
  end

  def create
    @company = current_user.companies.build(company_params)

    if @company.save
      redirect_to(company_url(@company), notice: "Company was successfully created")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
    add_breadcrumbs("Companies", companies_path)
    add_breadcrumbs("Edit", companies_path)
    add_breadcrumbs(@company.name, companies_path)
  end

  def update
    if @company.update(company_params)
      redirect_to(company_url(@company), notice: "Company was successfully updated")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @company.destroy

    redirect_to(companies_url, notice: "Company was successfully destroyed")
  end

  # users func methods
  def add_user
    user = User.find(params[:user_id])
    @company.add_user(user)
    redirect_to(@company, notice: 'User added to the company.')
  end

  def remove_user
    user = User.find(params[:user_id])
    @company.remove_user(user)
    redirect_to(@company, notice: 'User removed from the company.')
  end

  private

  def set_company
    @company = Company.friendly.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :description, :email)
  end
end
