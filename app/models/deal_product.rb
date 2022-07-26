# frozen_string_literal: true

class DealProduct < ApplicationRecord

  after_commit :update_deal_total_amount

  enum discount_types: {
    "None": 'none',
    "Percent": 'percent',
    "Fixed": 'fixed',
    "Free": 'free'
  }, _suffix: true

  belongs_to :deal
  belongs_to :product

  def price
    price_with_discount - discount
  end

  def discount
    case discount_type
    when 'none'
      0
    when 'percent'
      price_with_discount * (discount_amount / 100.0)
    when 'fixed'
      discount_amount
    when 'free'
      price_with_discount
    end
  end

  private

  def price_with_discount
    product.price * quantity
  end

  def update_deal_total_amount
    deal.update_total_amount
  end

end
