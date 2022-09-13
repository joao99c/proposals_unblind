# frozen_string_literal: true

class DealProduct < ApplicationRecord

  after_save_commit :update_deal_total_amount

  enum discount_types: {
    "None": 'none',
    "Percent": 'percent',
    "Fixed": 'fixed',
    "Free": 'free'
  }, _suffix: true

  belongs_to :deal
  belongs_to :product

  validates_numericality_of :quantity, less_than_or_equal_to: BigDecimal(10 ** 8)

  def price
    value = price_without_discount - discount
    if value.positive?
      value
    else
      0
    end
  end

  def discount
    # case discount_type
    # when 'none'
    #   0
    # when 'percent'
    #   price_with_discount * (discount_amount / 100.0)
    # when 'fixed'
    discount_amount
    # when 'free'
    #   price_with_discount
    # end
  end

  def price_without_discount
    product.price * quantity
  end
  
  private

  def update_deal_total_amount
    deal.update_total_amount
  end

end
