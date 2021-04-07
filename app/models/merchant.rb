class Merchant < ApplicationRecord

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  # scope :paginate, -> (page:, per_page: 20) {
  #   page = (page || 1).to_i
  #   current_scope = limit(per_page).offset((page - 1) * per_page)
  # }

  def revenue
    transactions
    .where("transactions.result = 'success'")
    .where("invoices.status = 'shipped'")
    .pluck("sum(invoice_items.quantity * invoice_items.unit_price) AS total")
    .first
    .round(2)
  end


  def self.top_merchants_revenue(num_merchants)
    joins(:transactions)
    .where("transactions.result = 'success'")
    .where("invoices.status = 'shipped'")
    .select("merchants.id, sum(invoice_items.quantity * invoice_items.unit_price)")
    .group("merchants.id")
    .order(sum: :desc)
    .limit(num_merchants)
  end

  def self.top_merchants_items(num_merchants)
    joins(:transactions)
    .where("transactions.result = 'success'")
    .where("invoices.status = 'shipped'")
    .select("merchants.id, sum(invoice_items.quantity)")
    .group("merchants.id")
    .order(sum: :desc)
    .limit(num_merchants)
  end

end
