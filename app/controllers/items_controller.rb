class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company
  before_action :set_invoice
  before_action :set_item, only: %i[show edit update destroy]

  layout 'dashboard'

  def index
    @items = @company.items
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to(company_item_url(@company, @item), notice: "Item was successfully created")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to(company_item_path(@company, @item), notice: 'Item was successfully updated')
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
  end

  private

  def set_company
    @company = Company.friendly.find(params[:company_id])
  end

  def set_invoice
    @invoice = Invoice.find_by(params[:id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:id, :quantity, :company_id, :invoice_id)
  end
end
