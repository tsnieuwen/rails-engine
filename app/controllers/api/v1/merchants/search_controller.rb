class Api::V1::Merchants::SearchController < ApplicationController

  def index
    merchant = Merchant.where("name ILIKE ?", "%#{params[:name].downcase}%").order(name: :asc).limit(1).first
    render json: MerchantSerializer.new(merchant)
  end

  # def index
  #   merchant = Merchant.order(name: :asc).find_by("name LIKE ?", "%#{params[:name]}%")
  #   render json: MerchantSerializer.new(merchant)
  # end


end
