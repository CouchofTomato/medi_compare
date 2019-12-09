class ProductModulesController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @product_module = @product.product_modules.new
    @benefits = Benefit.all
    @product_module_categories = ProductModule::CATEGORY_NAMES
  end
end
