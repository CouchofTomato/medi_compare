class ComparisonsController < ApplicationController
  before_action :authenticate_user!
  before_action :instantiate_benefit_categories, only: %i[new]

  def new
    @insurers = Insurer.all
    @benefits = helpers.group_by_category(Benefit.all)
    @benefit_categories = Benefit::CATEGORY_NAMES.select { |category| @benefits.keys.include? category }
  end

  def show
    puts params
  end

  private

  def comparison_params
    params.require(:comparison).permit(:selected_products)
  end

  def instantiate_benefit_categories
    @benefit_categories = Benefit::CATEGORY_NAMES
  end
end
