class Api::V1::Items::SearchController < ApplicationController

  def index
    # merchant = Merchant.where("name ILIKE ?", "%#{params[:name].downcase}%").order(name: :asc).limit(1).first
    # render json: MerchantSerializer.new(merchant)
  end

end
