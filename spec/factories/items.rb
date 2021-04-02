FactoryBot.define do
  FactoryBot.define do
    factory :item do
      name { Faker::Commerce.product_name }
      description { Faker::Quote.famous_last_words }
      unit_price { [0..100].sample.to_f }
      merchant
    end
  end
end
