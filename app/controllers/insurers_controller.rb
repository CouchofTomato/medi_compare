class InsurersController < ApplicationController
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

  private

  def insurer_params
    params.require(:insurer).permit(:name)
  end
end
