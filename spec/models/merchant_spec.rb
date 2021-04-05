require 'rails_helper'

describe Merchant do

  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
    it {should have_many(:invoices).through(:invoice_items)}
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  # describe '.paginate' do
  #   subject(:entries) { Merchant.paginate(page: 3, per_page: 2) }
  #   let!(:merchant1) {FactoryBot.create(:merchant)}
  #   let!(:merchant2) {FactoryBot.create(:merchant)}
  #   let!(:merchant3) {FactoryBot.create(:merchant)}
  #   let!(:merchant4) {FactoryBot.create(:merchant)}
  #   let!(:merchant5) {FactoryBot.create(:merchant)}
  #   let!(:merchant6) {FactoryBot.create(:merchant)}
  #   let!(:merchant7) {FactoryBot.create(:merchant)}
  #   let!(:merchant8) {FactoryBot.create(:merchant)}
  #
  #   it { is_expected.to eq([merchant5, merchant6]) }
  # end
end
