FactoryBot.define do
  FactoryBot.define do
    factory :item do
      name { Faker::Commerce.product_name }
      description { Faker::Quote.famous_last_words }
      unit_price { Faker::Number.decimal(l_digits: 2) }
      merchant
    end
  end
end
