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
    if params[:limit]
      params[:limit]
    else
      20
    end
  end

  def page_offset
    if params[:page_number]
      (params[:page_number].to_i - 1) * per_page.to_i
    else
      nil
    end
  end

end
