class ComparisonProductsController < ApplicationController
  def create
    # @comparison_product = Insurer.includes(
    #   products: { product_modules: { product_module_benefits: :benefit } }
    # ).where(
    #   id: params[:insurer],
    #   products: {
    #     id: params[:product],
    #     product_modules: selected_modules(params[:product_modules])
    #   }
    # )
    @comparison_products = comparison_product_params.to_h
    @insurer = Insurer.find(@comparison_products['insurer'])
    @product = Product.find(@comparison_products['product'])
    @benefits = Benefit.all
    @product_modules = ProductModule
                       .includes(product_module_benefits: :benefit)
                       .where(id: selected_modules(@comparison_products['product_modules']))
    @decorated_product_module_benefits = decorated_product_modules(@product_modules)
    respond_to do |format|
      format.js 
    end
  end

  def show; end

  private

  def comparison_product_params
    params.require(:comparison_product)
          .permit(:insurer, :product,
                  product_modules: %i[core outpatient medicines_and_appliances
                                      wellness maternity dental_and_optical
                                      evacuation_and_repatriation])
  end

  def selected_modules(modules)
    modules.values.flatten
  end

  def decorated_product_modules(product_modules)
    product_modules
      .map(&:product_module_benefits)
      .flatten
      .map { |prod_mod| ProductModuleBenefitDecorator.new(prod_mod) }
  end
end
