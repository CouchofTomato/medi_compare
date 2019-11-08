class ProductsController < ApplicationController
  def new
    @insurer = Insurer.find(params[:insurer_id])
    @product = Product.new
  end

  def create
    @insurer = Insurer.find(params[:insurer_id])
    @product = @insurer.products.build(product_params)
    if @product.save
      flash[:notice] = 'Product created'
      redirect_to insurer_path(@insurer)
    else
      flash.now[:warning] = 'Product could not be created'
      render :new
    end
  end

  def edit
    @insurer = Insurer.find(params[:insurer_id])
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @insurer = @product.insurer
    if @product.update(product_params)
      flash[:notice] = 'Product Successfully Updated'
      redirect_to insurer_path(@insurer)
    else
      flash.now[:warning] = 'Product could not be updated'
      render :edit
    end
  end

  private

  def product_params
    params.require(:product).permit(:name)
  end
end
