class InvoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_team
  before_action :set_project
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = Invoice.all
  end

  def show
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      redirect_to(company_team_project_invoices_path(@company, @team, @project), notice: 'Invoice was successfully created')
    else
      render(:new)
    end
  end

  def edit
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to(company_team_project_invoice_path(@company, @team, @project, @invoice), notice: 'Invoice was successfully updated')
    else
      render(:edit)
    end
  end

  def destroy
    @invoice.destroy
    redirect_to(company_team_project_invoices_path(@company, @team, @project), notice: 'Invoice was successfully destroyed')
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_team
    @team = Team.friendly.find(params[:team_id])
  end

  def set_project
    # @project = Project.friendly.find(params[:id])
  end

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:invoice_number, :client_name, :issue_date, :due_date, :amount, :project_id)
  end
end
