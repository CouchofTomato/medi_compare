class InsurersController < ApplicationController
  before_action :authenticate_user!

  def index
    @insurers = Insurer.search(params[:search])
    @insurer = Insurer.new
  end

  def new
    @insurer = Insurer.new
  end

  def create
    @insurer = Insurer.new(insurer_params)
    if @insurer.save
      flash[:notice] = 'New Insurer Created!'
      redirect_to insurers_path
    else
      flash.now[:warning] = 'Insurer could not be created'
      render :new
    end
  end

  def show
    @insurer = Insurer.find(params[:id])
    @products = @insurer.products.search(params[:search])
  end

  def edit
    @insurer = Insurer.find(params[:id])
  end

  def update
    @insurer = Insurer.find(params[:id])
    if @insurer.update(insurer_params)
      flash[:notice] = 'Insurer Successfully Updated'
      redirect_to insurers_path
    else
      flash.now[:warning] = 'Insurer could not be updated.'
      render :edit
    end
  end

  def destroy
    @insurer = Insurer.find(params[:id])
    if @insurer.destroy
      flash[:notice] = 'Insurer deleted!'
    else
      flash[:warning] = 'Insurer could not be deleted.'
    end
    redirect_to insurers_path
  end

  private

  def insurer_params
    params.require(:insurer).permit(:name)
  end
end
