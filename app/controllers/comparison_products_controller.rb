class ComparisonProductsController < ApplicationController
  def create
    @comparison_product = ComparisonProduct.new(comparison_product_params)
    respond_to do |format|
      format.js
    end
  end

  def show; end

  private

  def comparison_product_params
    params.require(:comparison_product)
          .permit(:insurer, :product, :product_modules)
  end
end
