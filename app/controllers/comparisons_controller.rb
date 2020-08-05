class ComparisonsController < ApplicationController
  before_action :authenticate_user!
  before_action :instantiate_benefit_categories, only: %i[new]

  def new
    @insurers = Insurer.all
    @benefits = helpers.group_by_category(Benefit.all)
    @benefit_categories = Benefit::CATEGORY_NAMES.select { |category| @benefits.keys.include? category }
  end

  def show
    selected_product_params = params[:selected_products]
    @selected_products = selected_product_params.map do |selected_product|
      insurer = Insurer.find(selected_product[:insurer])
      product = Product.find(selected_product[:product])
      product_modules = ProductModule.includes(product_module_benefits: :benefit).find(selected_modules(selected_product[:product_modules]))
      SelectedProduct.new(insurer, product, product_modules)
    end
    @grouped_benefits = Benefit.group_by_category
    @benefit_categories = Benefit::CATEGORY_NAMES.select { |category| @grouped_benefits.keys.include? category }
    respond_to do |format|
      format.xlsx
    end
  end

  private

  def comparison_params
    params.require(:comparison).permit(
      selected_products: [:insurer, :product,
                          product_modules: %i[core
                                              outpatient
                                              medicines_and_appliances
                                              wellness
                                              maternity
                                              dental_and_optical
                                              evacuation_and_repatriation]]
    )
  end

  def instantiate_benefit_categories
    @benefit_categories = Benefit::CATEGORY_NAMES
  end

  def selected_modules(modules)
    modules.values.flatten
  end
end
