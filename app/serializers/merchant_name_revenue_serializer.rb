class MerchantNameRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :name do |merchant|
    mer = Merchant.find(merchant.id)
    mer.name
  end

  attribute :revenue do |merchant|
    merchant.sum
  end


end
