class ProductsController < ApplicationController
  def new
    @insurer = Insurer.find(params[:insurer_id])
    @product = Product.new
  end
end
