class ProductsController < ApplicationController
  before_action :set_product

  def index
    @products = Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to(products_url(@product), notice: "Product was successfully created")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_product
    @product = Product.find_by(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end