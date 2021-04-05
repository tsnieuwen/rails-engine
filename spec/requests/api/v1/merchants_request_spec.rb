require 'rails_helper'

describe "Merchants API" do

  it "sends a list of merchants" do

    create_list(:merchant, 4)

    get '/api/v1/merchants'
    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(4)
    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)
    end
    # merchants.each do |merchant|
    #   expect(merchant).to have_key(:id)
    #   expect(merchant[:id]).to be_a(Integer)
    #   expect(merchant).to have_key(:name)
    #   expect(merchant[:name]).to be_a(String)
    # end
  end

  it "returns a subset of merchants based on limit" do
    create_list(:merchant, 35)
    get '/api/v1/merchants', params: {per_page: 15 }
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(15)
  end

  it "returns a subset of merchants based on limit and offset" do
    create_list(:merchant, 35)
    get '/api/v1/merchants', params: {per_page: 20, page: 2 }
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)
    expect(merchants[:data].count).to eq(15)
  end

  it "has a default limit of 20" do
    expect(Merchant).to receive(:limit).with(20).and_call_original

    get '/api/v1/merchants'
  end

  # it "won't take a page with value less than one" do
  #   expect(Merchant).to receive(:offset).with(0).and_call_original
  #   get '/api/v1/merchants', params: {page: -1 }
  #
  # end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"
  #
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
  #
  #   expect(merchant).to have_key(:id)
  #   expect(merchant[:id]).to eq(id)
  #   expect(merchant).to have_key(:name)
  #   expect(merchant[:name]).to be_a(String)

    # expect(merchant[:data][:attributes]).to have_key(:id)
    # expect(merchant[:data][:attributes][:id]).to eq(id)
    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)
  end
end
