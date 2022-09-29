# frozen_string_literal: true

class DealSection < ApplicationRecord
  include ActionView::RecordIdentifier

  acts_as_list scope: :deal, sequential_updates: false

  scope :ordered, -> { order(:position) }

  has_rich_text :text
  has_rich_text :address

  has_one_attached :background_image
  has_one_attached :logo

  belongs_to :deal
  belongs_to :section
  has_many :deal_section_items, foreign_key: :parent_id, dependent: :destroy
  accepts_nested_attributes_for :deal_section_items, allow_destroy: true, reject_if: :all_blank

  after_create_commit :broadcast_create
  after_update_commit :broadcast_update
  after_destroy_commit :broadcast_destroy

  def name
    heading
  end

  def parent
    DealSection.find(parent_id) if parent_id.present?
  end

  def button_valid
    button&.dig('text').present? && button&.dig('url').present?
  end

  def button2_valid
    button2&.dig('text').present? && button2&.dig('url').present?
  end

  def background_color
    theme.dig("colors", "background") if theme.present?
  end

  def heading_color
    theme.dig("colors", "heading") if theme.present?
  end

  def text_color
    theme.dig("colors", "text") if theme.present?
  end

  def button_background_color
    theme.dig("colors", "button_background") if theme.present?
  end

  def button_text_color
    theme.dig("colors", "button_text") if theme.present?
  end

  def customer_name
    deal.try(:customer).try(:name)
  end

  def send_date(format: '%d %B %Y')
    I18n.localize(deal.send_date, format:).titleize if deal.try(:send_date)
  end

  private

  def broadcast_create
    partial = 'admin/editor/deal_sections/deal_section'
    locals = { deal_section: self }
    target = if child == false
               'deal_sections_preview'
             else
               dom_id(parent, 'items')
             end
    broadcast_append_to(deal, :deal_sections_preview, target:, partial:, locals:)
  end

  def broadcast_update
    broadcast_replace_to(deal, :deal_sections_preview,
                         target: dom_id(self),
                         partial: 'admin/editor/deal_sections/deal_section',
                         locals: { deal_section: self })
  end

  def broadcast_destroy
    broadcast_remove_to(deal, :deal_sections_preview, target: dom_id(self))
  end
end
