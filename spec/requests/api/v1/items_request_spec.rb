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

  it "can create a new item" do
    merchant = create(:merchant).id
    item_params = ({
                    name: 'Computer',
                    description: 'This is your computer',
                    unit_price: 1200.59,
                    merchant_id: merchant
                    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last
    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    id = create(:item).id
    merchant = create(:merchant).id
    previous_name = Item.last.name
    previous_description = Item.last.description
    previous_unit_price = Item.last.unit_price
    item_params =  ({
                      name: 'Computer',
                      description: 'This is your computer',
                      unit_price: 1200.59,
                      merchant_id: merchant
                      })
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Computer")
    expect(item.description).to_not eq(previous_description)
    expect(item.description).to eq("This is your computer")
    expect(item.unit_price).to_not eq(previous_unit_price)
    expect(item.unit_price).to eq(1200.59)
  end

  it "can destroy an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

end