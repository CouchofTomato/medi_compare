class BenefitsController < ApplicationController
  before_action :instantiate_benefit_categories, only: [:index, :create]

  def index
    @benefits = Benefit.all
    @benefit = Benefit.new
  end

  private

  def benefit_params
    params.require(:benefit).permit(:name, :category)
  end

  def instantiate_benefit_categories
    @benefit_categories = Benefit::CATEGORY_NAMES
  end
end
