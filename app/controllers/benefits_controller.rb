class BenefitsController < ApplicationController
  before_action :authenticate_user!
  before_action :instantiate_benefit_categories, only: [:index, :create, :new, :edit, :update]

  def index
    @benefits = Benefit.search(params[:search])
    @benefit = Benefit.new
  end

  def new
    @benefit = Benefit.new
  end

  def create
    @benefit = Benefit.new(benefit_params)
    if @benefit.save
      flash[:notice] = 'New Benefit Created!'
      redirect_to benefits_path
    else
      flash[:warning] = 'Benefit could not be created.'
      render :new
    end
  end

  def edit
    @benefit = Benefit.find(params[:id])
  end

  def update
    @benefit = Benefit.find(params[:id])
    if @benefit.update(benefit_params)
      flash[:notice] = 'Benefit Successfully Updated'
      redirect_to benefits_path
    else
      flash[:warning] = 'Benefit could not be updated.'
      render :edit
    end
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
