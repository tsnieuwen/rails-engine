require 'rails_helper'

describe "Merchants API" do

  it "sends a list of merchants" do

    merchant = FactoryBot.create(:merchant, name: "Tex Berry's")
    create_list(:merchant, 4)

    get '/api/v1/merchants'
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(4)
    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end


end
