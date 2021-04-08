class Api::V1::Merchants::SearchController < ApplicationController

  def index
    merchant = Merchant.where("name ILIKE ?", "%#{params[:name].downcase}%").order(name: :asc).limit(1).first
    if merchant.class == Merchant
      render json: MerchantSerializer.new(merchant)
    else
      render json: {data: { error: "Your search could not be completed because you did not pass in a valid query parameter"}}, status: 404
    end
  end

  def most_items
    if params[:quantity]
      if params[:quantity].to_i >= 1
        @merchants = Merchant.top_merchants_items(params[:quantity].to_i)
        @serial = ItemsSoldSerializer.new(@merchants)
        render json: @serial
      else
        render json: {data: { error: "Your search could not be completed because you did not pass in a valid query parameter"}}, status: 400
      end
    else
      render json: {error: "Your search could not be completed because you did not pass in a query parameter"}, status: 400
    end
  end

  # def index
  #   merchant = Merchant.order(name: :asc).find_by("name LIKE ?", "%#{params[:name]}%")
  #   render json: MerchantSerializer.new(merchant)
  # end


end
