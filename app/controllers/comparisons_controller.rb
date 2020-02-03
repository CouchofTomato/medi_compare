class ComparisonsController < ApplicationController
  before_action :authenticate_user!

  def new
    @insurers = Insurer.all
  end
end
