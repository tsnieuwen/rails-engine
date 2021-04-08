class Api::V1::ItemsController < ApplicationController

  def index

    items = Item.limit(per_page.to_i).offset(page_offset)

    render json: ItemSerializer.new(items)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.create(item_params)
    render json: ItemSerializer.new(item), status: :created
  end

  def update
    if params[:merchant_id]
      if Merchant.find(params[:merchant_id])
        item = Item.find(params[:id])
        item.update!(item_params)
        render json: ItemSerializer.new(item)
      else
        render json: "404 not found", status: 404
      end
    else
      item = Item.find(params[:id])
      item.update!(item_params)
      render json: ItemSerializer.new(item)
    end
  end

  def destroy
    item = Item.delete(params[:id])
    item.delete_invoices
    item.destroy
  end

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
