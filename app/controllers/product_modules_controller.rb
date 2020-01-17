class ProductModulesController < ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @product_module = @product.product_modules.new
    @benefits = Benefit.all
    @product_module_categories = ProductModule::CATEGORY_NAMES
  end

  def create
    @product = Product.find(params[:product_id])
    @product_module = @product.product_modules.build(product_module_params)
    if @product_module.save
      flash[:notice] = 'New Product Module Created!'
      redirect_to product_path(@product)
    else
      flash.now[:warning] = 'Product Module could not be created'
      render :new
    end
  end

  private

  def product_module_params
    params.require(:product_module)
          .permit(
            :name,
            :category,
            :sum_assured,
            product_module_benefits_attributes: %i[benefit_id benefit_coverage explanation_of_benefits]
          )
  end
end
