require 'rails_helper'

describe "Items API" do

  it "searches for all items based on search param that matches item name or description" do

    merchant1 = FactoryBot.create(:merchant)
    item1 = FactoryBot.create(:item, name: "Water Bottle", description: "Store your drink", unit_price: 12.34, merchant_id: merchant1.id)
    item2 = FactoryBot.create(:item, name: "Sink", description: "Holds Water", unit_price: 100, merchant_id: merchant1.id)
    item3 = FactoryBot.create(:item, name: "Bottle Cap", description: "Seals drink container", unit_price: 0.99, merchant_id: merchant1.id)


    get '/api/v1/items/find_all', params: {name: "water" }
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    require "pry"; binding.pry
    # expect(merchant[:data][:attributes][:name]).to eq(merchant3.name)
  end

end
