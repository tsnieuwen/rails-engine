class ItemRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :name do |item|
    object = Item.find(item.id)
    object.name
  end

  attribute :description do |item|
    object = Item.find(item.id)
    object.description
  end

  attribute :unit_price do |item|
    object = Item.find(item.id)
    object.unit_price
  end

  attribute :merchant_id do |item|
    object = Item.find(item.id)
    object.merchant_id
  end

  attribute :revenue do |item|
    item.sum
  end

end
