class Api::V1::Items::SearchController < ApplicationController

  def index
    if params[:name]
      # items = (Item.where("description ILIKE ?", "%#{params[:name].downcase}%").or(Item.where("name ILIKE ?", "%#{params[:name].downcase}%"))).where("unit_price >= ?", minimum).where("unit_price <= ?", maximum)
      items = (Item.where("name ILIKE ?", "%#{params[:name].downcase}%")).where("unit_price >= ?", minimum).where("unit_price <= ?", maximum)
    else
      items = Item.where("unit_price >= ?", minimum).where("unit_price <= ?", maximum)
    end
    render json: ItemSerializer.new(items)
  end

  private

  def maximum
    if params[:maximum]
      params[:maximum].to_i
    else
      Item.maximum(:unit_price)
    end
  end

  def minimum
    if params[:minimum]
      params[:minimum].to_i
    else
      Item.minimum(:unit_price)
    end
  end


end
