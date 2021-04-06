class Api::V1::ItemsController < ApplicationController

  def index

    items = Item.limit(per_page.to_i).offset(page_offset)

    render json: ItemSerializer.new(items)
  end

  # def show
  #   render json: Item.find(params[:id])
  # end
  #
  # def create
  #   render json: Item.create(item_params)
  # end
  #
  # def update
  #   render json: Item.update(params[:id], item_params)
  # end
  #
  # def destroy
  #   render json: Item.delete(params[:id])
  # end

  private

    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end

# def index
#   merchants = Merchant.limit(per_page.to_i).offset(page_offset)
#
#   render json: MerchantSerializer.new(merchants)
# end

# def show
#   render json: MerchantSerializer.new(Merchant.find(params[:id]))
# end

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
