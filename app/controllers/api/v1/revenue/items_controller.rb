class Api::V1::Revenue::ItemsController < ApplicationController

  def index
    if params[:quantity]
      if params[:quantity].to_i >= 1
        @items = Item.top_items_revenue(params[:quantity].to_i)
        @serial = ItemRevenueSerializer.new(@items)
        render json: @serial
      else
        render json: {data: { error: "Your search could not be completed because you did not pass in a valid query parameter"}}, status: 400
      end
    else
      @items = Item.top_items_revenue(10)
      @serial = ItemRevenueSerializer.new(@items)
      render json: @serial
    end
  end

end
