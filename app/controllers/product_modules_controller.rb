class ProductModulesController < ApplicationController
  before_action :instantiate_benefit_module_categories, only: %i[new create edit]

  def new
    @product = Product.find(params[:product_id])
    @product_module = @product.product_modules.new
    @product_module_benefits = @product_module.product_module_benefits.includes(:benefit)
    @benefits = Benefit.all
  end

  def create
    @product = Product.find(params[:product_id])
    @product_module = @product.product_modules.build(product_module_params)
    @product_module_benefits = params['product_module']['product_module_benefits_attributes']
    @benefits = Benefit.all
    @selected_benefits = @product_module_benefits.values.map { |benefit| benefit['benefit_id'] }
    if @product_module.save
      flash[:notice] = 'New Product Module Created!'
      redirect_to product_path(@product)
    else
      flash.now[:warning] = 'Product Module could not be created'
      render :new
    end
  end

  def edit
    @product_module = ProductModule.find(params[:id])
    @product_module_benefits = @product_module.product_module_benefits.includes(:benefit)
    @selected_benefits = @product_module.benefits.map(&:id)
    @product = @product_module.product
    @benefits = Benefit.all
  end

  def update
    @product_module = ProductModule.find(params[:id])
    @product = @product_module.product
    @benefits = Benefit.all

    if @product_module.update(product_module_params)
      flash[:notice] = 'Product Module Successfully Updated'
      redirect_to product_path(@product)
    else
      flash.now[:warning] = 'Product Module could not be updated'
      render :edit
    end
  end

  def destroy
    @product_module = ProductModule.find(params[:id])
    @product = @product_module.product

    if @product_module.destroy
      flash[:notice] = 'Product Module deleted!'
    else
      flash[:warning] = 'Product Module could not be deleted'
    end
    redirect_to product_path(@product)
  end

  private

  def product_module_params
    params.require(:product_module)
          .permit(
            :name,
            :category,
            :sum_assured,
            product_module_benefits_attributes: %i[id benefit_id benefit_coverage explanation_of_benefit]
          )
  end

  def instantiate_benefit_module_categories
    @product_module_categories = ProductModule::CATEGORY_NAMES
  end
end
