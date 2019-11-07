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

  private

  def product_params
    params.require(:product).permit(:name)
  end
end