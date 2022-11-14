class Product < ApplicationRecord
  acts_as_tenant(:user)

  has_one_attached :image
  has_many :deal_products

  after_save_commit :update_price

  def update_price
    deal_products.map(&:update_deal_total_amount)
  end

  validates_presence_of :name, :price
  validates_uniqueness_of :name, scope: :user_id

end
