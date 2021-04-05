class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = Merchant.limit(per_page.to_i).offset(page_offset)

    render json: MerchantSerializer.new(merchants)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  private

  def per_page
    if params[:per_page]
      params[:per_page]
    else
      20
    end
  end

  def page_offset
    if !params[:page]
      nil
    elsif params[:page].to_i <= 0
      0
    else
      (params[:page].to_i - 1) * per_page.to_i
    end
  end

end
