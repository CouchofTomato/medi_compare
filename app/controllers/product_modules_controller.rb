class ProductModulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_module_categories, only: %i[new create edit]
  before_action :set_coverage_options, only: %i[new create edit]

  def index
    @product = Product.find(params[:product_id])
    @product_modules = @product.product_modules.group_by(&:category)
    @product_module_categories = ProductModule::CATEGORY_NAMES.select { |category| @product_modules.keys.include? category }
    respond_to do |format|
      format.js
    end
  end

  def new
    @product = Product.find(params[:product_id])
    @product_module = @product.product_modules.new
    @product_module_benefits = @product_module.product_module_benefits.includes(:benefit)
    @benefits = Benefit.all
  end

  def create
    @product = Product.find(params[:product_id])
    @product_module = @product.product_modules.build(product_module_params)
    @product_module_benefits = (params.dig 'product_module', 'product_module_benefits_attributes') || {}
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

  def show
    @product_module = ProductModule.find(params[:id])
    @product = @product_module.product
    @product_module_benefits = @product_module.product_module_benefits.includes(:benefit)
    @insurer = @product.insurer
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
            product_module_benefits_attributes: %i[_destroy id benefit_id benefit_limit benefit_coverage explanation_of_benefit]
          )
  end

  def set_module_categories
    @product_module_categories = ProductModule::CATEGORY_NAMES
  end

  def set_coverage_options
    @coverage_options = ProductModuleBenefit::COVERAGE_OPTIONS
  end
end
