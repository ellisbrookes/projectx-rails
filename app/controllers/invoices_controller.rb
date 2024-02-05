class InvoicesController < ApplicationController
  layout 'dashboard'

  before_action :authenticate_user!
  before_action :set_company
  before_action :set_invoice, only: %i[show edit update]

  def index
    @invoices = @company.invoices
    add_breadcrumbs("Invoices", company_invoices_path)
  end

  def show
    add_breadcrumbs("Invoices", company_invoices_path)
    add_breadcrumbs(@invoice.invoice_issue)
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to(company_invoice_path(@company, @invoice), notice: 'Invoice was successfully created')
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
    add_breadcrumbs("Invoices", company_invoices_path)
    add_breadcrumbs("Edit")
    add_breadcrumbs(@invoice.invoice_issue, company_invoice_path)
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to(company_invoice_path(@company, @invoice), notice: 'Invoice was successfully updated')
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:invoice_issue, :customer, :issue_date, :due_date, :customer_address, :company_address, :notes, :amount, :company_id, :currency)
  end
end
