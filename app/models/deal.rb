# frozen_string_literal: true

class Deal < ApplicationRecord
  include Admin::AdminResource

  # Relationships
  has_many :deal_products, dependent: :destroy
  accepts_nested_attributes_for :deal_products, allow_destroy: true, reject_if: :all_blank

  belongs_to :user, optional: true

  belongs_to :customer, optional: true
  accepts_nested_attributes_for :customer

  # Validations
  validates :name, presence: true
  validates :user, :customer, presence: true, on: :update

  # kaminari
  paginates_per 5

  # Table columns
  column :name
  column :customer
  column :user
  column :total_amount
  column :finish_date

  # Table column custom filters
  ransacker :id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end
  ransacker :user_id do
    Arel.sql("to_char(\"#{table_name}\".\"user_id\", '99999999')")
  end
  ransacker :customer_id do
    Arel.sql("to_char(\"#{table_name}\".\"customer_id\", '99999999')")
  end

  def update_total_amount
    self.total_amount = deal_products.map(&:price).sum
    save
  end
end
