require 'rails_helper'

RSpec.describe Item, type: :model do

  before :each do
    @merchant1 = Merchant.create(name: 'Hair Care')
    @merchant2 = Merchant.create(name: 'Jewelry')
    @merchant3 = Merchant.create(name: 'Pet Store')

    @item_1 = Item.create(name: "Shampoo", description: "This cleans your hair", unit_price: 10.32, merchant_id: @merchant1.id)
    @item_2 = Item.create(name: "Conditioner", description: "This keeps your hair silky and smooth", unit_price: 11.87, merchant_id: @merchant1.id)
    @item_3 = Item.create(name: "Swan", description: "Stop looking at me swan", unit_price: 123.64, merchant_id: @merchant1.id)

    @item_4 = Item.create(name: "Phone", description: "Calls", unit_price: 60.26, merchant_id: @merchant2.id)
    @item_5 = Item.create(name: "Water", description: "Drink", unit_price: 49.99, merchant_id: @merchant2.id)
    @item_6 = Item.create(name: "Headphones", description: "Listen", unit_price: 0.99, merchant_id: @merchant2.id)

    @item_7 = Item.create(name: "TV", description: "Watch", unit_price: 249.99, merchant_id: @merchant3.id)
    @item_8 = Item.create(name: "Patio Set", description: "Sit", unit_price: 899.99, merchant_id: @merchant3.id)


    @customer_1 = Customer.create(first_name: 'Joey', last_name: 'Smith')
    @customer_2 = Customer.create(first_name: 'Cecilia', last_name: 'Jones')
    @customer_3 = Customer.create(first_name: 'Mariah', last_name: 'Carrey')
    @customer_4 = Customer.create(first_name: 'Leigh Ann', last_name: 'Bron')
    @customer_5 = Customer.create(first_name: 'Sylvester', last_name: 'Nader')
    @customer_6 = Customer.create(first_name: 'Herber', last_name: 'Coon')
    @customer_7 = Customer.create(first_name: 'Hank', last_name: 'Aaron')
    @customer_8 = Customer.create(first_name: 'Barry', last_name: 'Bonds')
    @customer_9 = Customer.create(first_name: 'Roger', last_name: 'Clemens')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 'packaged', merchant_id: @merchant1.id)
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 'shipped', merchant_id: @merchant1.id)
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 'shipped', merchant_id: @merchant1.id)
    @invoice_4 = Invoice.create!(customer_id: @customer_4.id, status: 'packaged', merchant_id: @merchant2.id)
    @invoice_5 = Invoice.create!(customer_id: @customer_5.id, status: 'shipped', merchant_id: @merchant2.id)
    @invoice_6 = Invoice.create!(customer_id: @customer_6.id, status: 'shipped', merchant_id: @merchant2.id)
    @invoice_7 = Invoice.create!(customer_id: @customer_7.id, status: 'shipped', merchant_id: @merchant3.id)
    @invoice_8 = Invoice.create!(customer_id: @customer_8.id, status: 'shipped', merchant_id: @merchant3.id)

    @ii_1 = InvoiceItem.create(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10)
    @ii_2 = InvoiceItem.create(invoice_id: @invoice_2.id, item_id: @item_2.id, quantity: 1, unit_price: 10)
    @ii_3 = InvoiceItem.create(invoice_id: @invoice_3.id, item_id: @item_3.id, quantity: 2, unit_price: 8)
    @ii_4 = InvoiceItem.create(invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 3, unit_price: 5)
    @ii_5 = InvoiceItem.create(invoice_id: @invoice_5.id, item_id: @item_5.id, quantity: 1, unit_price: 1)
    @ii_6 = InvoiceItem.create(invoice_id: @invoice_6.id, item_id: @item_6.id, quantity: 1, unit_price: 3)
    @ii_7 = InvoiceItem.create(invoice_id: @invoice_7.id, item_id: @item_7.id, quantity: 4, unit_price: 5)
    @ii_8 = InvoiceItem.create(invoice_id: @invoice_8.id, item_id: @item_8.id, quantity: 1, unit_price: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 'failed', invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 'success', invoice_id: @invoice_2.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 'success', invoice_id: @invoice_3.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 'success', invoice_id: @invoice_4.id)
    @transaction5 = Transaction.create!(credit_card_number: 230429, result: 'success', invoice_id: @invoice_5.id)
    @transaction6 = Transaction.create!(credit_card_number: 230429, result: 'success', invoice_id: @invoice_6.id)
    @transaction7 = Transaction.create!(credit_card_number: 230429, result: 'success', invoice_id: @invoice_7.id)
    @transaction8 = Transaction.create!(credit_card_number: 230429, result: 'success', invoice_id: @invoice_8.id)
  end

  describe "relationships" do
    it { should have_many :invoice_items}
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe 'instance methods' do
    it 'delete_invoices' do
      @item_1.delete_invoices
      expect(Invoice.all).to_not include(@invoice_1)
    end
  end

  describe 'class methods' do
    it 'top_items_revenue' do
      expect(Item.top_items_revenue(2).first.id).to eq(@item_7.id)
      expect(Item.top_items_revenue(2).second.id).to eq(@item_3.id)
    end
  end
end
