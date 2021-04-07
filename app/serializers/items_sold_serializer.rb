class ItemsSoldSerializer
  include FastJsonapi::ObjectSerializer

  attribute :name do |merchant|
    mer = Merchant.find(merchant.id)
    mer.name
  end

  attribute :count do |merchant|
    merchant.sum
  end
end
