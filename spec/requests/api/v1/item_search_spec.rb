require 'rails_helper'

describe "Items API" do

  it "searches for all items based on search param that matches item name or description" do

    merchant1 = FactoryBot.create(:merchant)
    item1 = FactoryBot.create(:item, name: "Water Bottle", description: "Store your drink", unit_price: 12.34, merchant_id: merchant1.id)
    item2 = FactoryBot.create(:item, name: "Sink", description: "Holds Water", unit_price: 100, merchant_id: merchant1.id)
    item3 = FactoryBot.create(:item, name: "Bottle Cap", description: "Seals drink container", unit_price: 0.99, merchant_id: merchant1.id)


    get '/api/v1/items/find_all', params: {name: "cap" }
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].first[:attributes][:name]).to eq(item3.name)
  end

  it "searches for all items based on minimum unit price param" do

    merchant1 = FactoryBot.create(:merchant)
    item1 = FactoryBot.create(:item, name: "Water Bottle", description: "Store your drink", unit_price: 12.34, merchant_id: merchant1.id)
    item2 = FactoryBot.create(:item, name: "Sink", description: "Holds Water", unit_price: 100, merchant_id: merchant1.id)
    item3 = FactoryBot.create(:item, name: "Bottle Cap", description: "Seals drink container", unit_price: 0.99, merchant_id: merchant1.id)


    get '/api/v1/items/find_all', params: {minimum: 1.00 }
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].first[:attributes][:name]).to eq(item1.name)
    expect(items[:data].second[:attributes][:name]).to eq(item2.name)
  end

  it "searches for all items based on maximum unit price param" do

    merchant1 = FactoryBot.create(:merchant)
    item1 = FactoryBot.create(:item, name: "Water Bottle", description: "Store your drink", unit_price: 12.34, merchant_id: merchant1.id)
    item2 = FactoryBot.create(:item, name: "Sink", description: "Holds Water", unit_price: 100, merchant_id: merchant1.id)
    item3 = FactoryBot.create(:item, name: "Bottle Cap", description: "Seals drink container", unit_price: 0.99, merchant_id: merchant1.id)


    get '/api/v1/items/find_all', params: {maximum: 1.00 }
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].first[:attributes][:name]).to eq(item3.name)
  end

  it "searches for all items based on maximum and minimum unit price param" do

    merchant1 = FactoryBot.create(:merchant)
    item1 = FactoryBot.create(:item, name: "Water Bottle", description: "Store your drink", unit_price: 12.34, merchant_id: merchant1.id)
    item2 = FactoryBot.create(:item, name: "Sink", description: "Holds Water", unit_price: 100, merchant_id: merchant1.id)
    item3 = FactoryBot.create(:item, name: "Bottle Cap", description: "Seals drink container", unit_price: 0.99, merchant_id: merchant1.id)


    get '/api/v1/items/find_all', params: {minimum: 1.00, maximum: 23.00 }
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].first[:attributes][:name]).to eq(item1.name)
  end

  it "searches for all items based on name, maximum unit price, and minimum unit price params" do

    merchant1 = FactoryBot.create(:merchant)
    item1 = FactoryBot.create(:item, name: "Water Bottle", description: "Store your drink", unit_price: 12.34, merchant_id: merchant1.id)
    item2 = FactoryBot.create(:item, name: "Water", description: "Holds Water", unit_price: 100, merchant_id: merchant1.id)
    item3 = FactoryBot.create(:item, name: "good Water", description: "Holds Water", unit_price: 22, merchant_id: merchant1.id)
    item4 = FactoryBot.create(:item, name: "Bottle Cap", description: "Seals drink container", unit_price: 0.99, merchant_id: merchant1.id)
    item5 = FactoryBot.create(:item, name: "Water Bottle", description: "Store your drink", unit_price: 12.34, merchant_id: merchant1.id)
    item6 = FactoryBot.create(:item, name: "Bottle", description: "Store your drink", unit_price: 12.34, merchant_id: merchant1.id)

    get '/api/v1/items/find_all', params: {minimum: 1.00, maximum: 23.00, name: 'water' }
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)
    expect(items[:data].first[:attributes][:name]).to eq(item1.name)
    expect(items[:data].second[:attributes][:name]).to eq(item3.name)
    expect(items[:data].third[:attributes][:name]).to eq(item5.name)
  end

end
