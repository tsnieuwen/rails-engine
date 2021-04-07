class Api::V1::Revenue::MerchantsController < ApplicationController

  def index
    if params[:quantity]
      if params[:quantity].to_i >= 1
        @merchants = Merchant.top_merchants_revenue(params[:quantity].to_i)
        @serial = MerchantNameRevenueSerializer.new(@merchants)
        render json: @serial
      else
        render json: {data: { error: "Your search could not be completed because you did not pass in a valid query parameter"}}, status: 400
      end
    else
      render json: {error: "Your search could not be completed because you did not pass in a query parameter"}, status: 400
    end
  end

  def show
    @merchant = Merchant.find(params[:id])
    @serial = MerchantRevenueSerializer.new(@merchant)
    render json: @serial
  end


end
