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
    @insurer = Insurer.find(params[:insurer])
    @product = Product.find(params[:product])
    @product_modules = ProductModule
                       .includes(product_module_benefits: :benefit)
                       .where(id: selected_modules(params[:product_modules]))

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
end
