class CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: %i[show edit update destroy update_users]

  layout 'dashboard'

  def index
    @companies = Company.where(user: current_user)
  end

  def show
  end

  def new
    @company = Company.new
  end

  def create
    @company = current_user.companies.build(company_params)

    if @company.save
      redirect_to(company_url(@company), notice: "Company was successfully created.")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to(company_url(@company), notice: "Company was successfully updated.")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @company.destroy

    redirect_to(companies_url, notice: "Company was successfully destroyed.")
  end

  # custom methods
  def update_users
    user = User.find(params[:company][:id])
    @company.users << user unless @company.users.include?(user)

    redirect_to(@company, notice: 'User added to the company.')
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :description, :email, users: [])
  end
end
