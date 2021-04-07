class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer

    attributes :revenue do |merchant|
      merchant.revenue
    end

end
