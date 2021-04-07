class Item < ApplicationRecord

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant
  has_many :transactions, through: :invoices

  def self.top_items_revenue(num_items)
    joins(:transactions)
    .where("transactions.result = 'success'")
    .where("invoices.status = 'shipped'")
    .select("items.id, sum(invoice_items.quantity * invoice_items.unit_price)")
    .group("items.id")
    .order(sum: :desc)
    .limit(num_items)
  end

end
