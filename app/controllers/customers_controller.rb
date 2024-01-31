class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: %i[show edit update destroy]

  layout 'dashboard'

  def index
    @customers = Customer.all
  end

  def show
    @companies = Company.where(company_id: @company.id)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = current_user.customers.build(customer_params)

    if @customer
      redirect_to(company_customer_url(@company), notice: "Customer was successfully created")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to(company_customer_url(@company), notice: "Customer was successfully updated")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @customer.destroy

    redirect_to(company_customers_url(@company), notice: "Customer was successfully destroyed")
  end

  private

  def set_company
    @company = Company.friendly.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:full_name, :address, :phone_number, :email, :notes, :company_id)
  end
end