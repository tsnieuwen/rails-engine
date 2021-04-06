require 'rails_helper'

describe "Merchants API" do

  it "searches for a single merchant based on search name parameter" do
    Merchant.destroy_all

    merchant1 = FactoryBot.create(:merchant, name: "Tex Berry's")
    merchant2 = FactoryBot.create(:merchant, name: "Texas Roadhouse")
    merchant3 = FactoryBot.create(:merchant, name: "Berries R Us")
    merchant4 = FactoryBot.create(:merchant, name: "US Postal Service")
    merchant5 = FactoryBot.create(:merchant, name: "House Fixer")


    get '/api/v1/merchants/find', params: {name: "Ber" }
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data][:attributes][:name]).to eq(merchant3.name)
  end

end
