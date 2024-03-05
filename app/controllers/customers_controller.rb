class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_customer, only: %i[show edit update destroy load_data]

  layout 'dashboard'

  def index
    @customers = @company.customers
    add_breadcrumbs("Customers", company_customers_path)
  end

  def show
    add_breadcrumbs("Customers", company_customers_path)
    add_breadcrumbs(@customer.full_name)
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to(company_customer_url(@company, @customer), notice: "Customer was successfully created")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
    add_breadcrumbs("Customers", company_customers_path)
    add_breadcrumbs("Edit")
    add_breadcrumbs(@customer.full_name, company_customer_path)
  end

  def update
    if @customer.update(customer_params)
      redirect_to(company_customer_url(@company, @customer), notice: "Customer was successfully updated")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @customer.destroy
    redirect_to(company_customers_url(@company), notice: "Customer was successfully destroyed")
  end

  def load_data
    render json: { address: @customer.address, notes: @customer.notes }
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_customer
    @customer = Customer.friendly.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:full_name, :address, :phone_number, :email, :notes, :company_id)
  end
end
