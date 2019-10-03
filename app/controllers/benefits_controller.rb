class BenefitsController < ApplicationController
  before_action :instantiate_benefit_categories, only: [:index, :create]

  def index
    @benefits = Benefit.all
    @benefit = Benefit.new
  end

  def destroy
    @benefit = Benefit.find(params[:id])
    if @benefit.destroy
      flash[:notice] = 'Benefit deleted!'
    else
      flash[:warning] = 'Benefit could not be deleted.'
    end
    redirect_to benefits_path
  end

  private

  def benefit_params
    params.require(:benefit).permit(:name, :category)
  end

  def instantiate_benefit_categories
    @benefit_categories = Benefit::CATEGORY_NAMES
  end
end
