require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 4)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)
    items.each do |item|
      expect(item).to have_key('id')
      expect(item['id']).to be_a(Integer)
      expect(item).to have_key('name')
      expect(item['name']).to be_a(String)
      expect(item).to have_key('description')
      expect(item['description']).to be_a(String)
      expect(item).to have_key('unit_price')
      expect(item['unit_price']).to be_a(Float)
    end
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to eq(id)

    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)

    expect(item).to have_key(:description)
    expect(item[:description]).to be_a(String)

    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a(Float)

    expect(item).to have_key(:merchant_id)
    expect(item[:merchant_id]).to be_a(Integer)
  end

end
