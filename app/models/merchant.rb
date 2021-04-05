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
end
