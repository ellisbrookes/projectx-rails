class ProductsController < ApplicationController
  before_action :set_product, only: %i[index]

  def index
    @products = Product.all
  end

  private

  def set_product
    @product = Product.find_by(params[:id])
  end

  def product_params
    params.require(:product).permit(:id, :name, :description, :price)
  end
end