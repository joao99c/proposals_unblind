class Product < ApplicationRecord
  has_one_attached :image
  has_many :deal_products

  after_save_commit :update_price

  def update_price
    deal_products.map(&:update_deal_total_amount)
  end
end
