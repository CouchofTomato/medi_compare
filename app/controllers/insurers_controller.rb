class InsurersController < ApplicationController
  def index
    @insurers = Insurer.search(params[:search])
    @insurer = Insurer.new
  end
end
