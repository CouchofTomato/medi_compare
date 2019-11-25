class ProductModulesController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @product_module = @product.product_modules.new
    @benefits = Benefit.all
  end
end
