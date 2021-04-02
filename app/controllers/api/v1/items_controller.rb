class Api::V1::ItemsController < ApplicationController

  def index
    render json: Item.all
  end

  # def show
  #   render json: Merchant.find(params[:id])
  # end

end
