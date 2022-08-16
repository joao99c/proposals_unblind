# frozen_string_literal: true

class DealSection < ApplicationRecord
  include ActionView::RecordIdentifier

  acts_as_list scope: :deal, sequential_updates: false

  scope :ordered, -> { order(:position) }

  belongs_to :deal
  belongs_to :section
  has_many :deal_section_items, foreign_key: :parent_id, dependent: :destroy

  after_create_commit :broadcast_create
  after_update_commit :broadcast_update
  after_destroy_commit :broadcast_destroy

  def name
    "#{section.name} - #{heading}"
  end

  def parent
    DealSection.find(parent_id) if parent_id.present?
  end

  private

  def broadcast_create
    partial = 'admin/editor/deal_sections/deal_section'
    locals = { deal_section: self }
    target = if self.child == false
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
