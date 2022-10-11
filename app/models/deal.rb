# frozen_string_literal: true

class Deal < ApplicationRecord
  include ActionView::RecordIdentifier

  acts_as_tenant(:user)

  after_create do
    self.uuid = generate_uuid
    while !save
      self.uuid = generate_uuid
    end
  end

  validates_uniqueness_of :uuid, on: :update

  STATUSES_ORDER = %w[open won lost].freeze

  enum status: {
    "Aberta": 'open',
    "Perdida": 'lost',
    "Ganha": 'won'
  }, _suffix: true

  scope :won, -> { where(status: 'won') }
  scope :lost, -> { where(status: 'lost') }
  scope :open, -> { where(status: 'open') }

  scope :newest_first, -> { order(created_at: :desc) }
  scope :index_set, -> { newest_first }

  # Relationships
  has_many :taggings, dependent: :destroy
  has_many :tags, -> { order(:name) }, through: :taggings

  has_many :deal_products, dependent: :destroy
  accepts_nested_attributes_for :deal_products, allow_destroy: true, reject_if: :all_blank
  has_many :products, through: :deal_products

  belongs_to :customer, optional: true
  accepts_nested_attributes_for :customer

  belongs_to :template, optional: true

  belongs_to :heading_typeface, class_name: 'Font', foreign_key: 'heading_typeface_id'
  belongs_to :text_typeface, class_name: 'Font', foreign_key: 'text_typeface_id'
  belongs_to :section_heading_typeface, class_name: 'Font', foreign_key: 'section_heading_typeface_id'
  belongs_to :sub_section_heading_typeface, class_name: 'Font', foreign_key: 'sub_section_heading_typeface_id'
  belongs_to :link_typeface, class_name: 'Font', foreign_key: 'link_typeface_id'
  belongs_to :button_typeface, class_name: 'Font', foreign_key: 'button_typeface_id'

  # Validations
  validates :name, presence: true

  def total_amount
    total_subtotal - total_discount + total_iva
  end

  def total_iva
    total_subtotal * user.iva / 100
  end

  def send_date_formatted(format: '%d %B %Y')
    if send_date.present?
      I18n.localize(send_date, format:).titleize
    else
      I18n.localize(DateTime.now, format:).titleize
    end
  end

  def update_total_amount
    self.total_subtotal = 0
    self.total_discount = 0
    deal_products.map do |dp|
      self.total_subtotal += dp.price_without_discount
      self.total_discount += dp.discount_amount
    end
    broadcast_replace_to(self, :product_total, target: :product_total, partial: 'admin/deals/product_total_footer', locals: { deal: self })
    save
  end

  def section_cabecalho
    template.section_cabecalho
  end

  def section_propostas
    template.section_propostas
  end

  def broadcast_preview_create(deal_section)
    partial = 'admin/editor/deal_sections/deal_section'
    locals = { deal_section: }
    target = if deal_section.child == false
               'deal_sections_preview'
             else
               dom_id(deal_section.parent, 'items')
             end
    broadcast_append_to(self, :deal_sections_preview, target:, partial:, locals:)
  end

  def broadcast_preview_update(deal_section)
    broadcast_replace_to(self,
                         :deal_sections_preview,
                         target: dom_id(deal_section),
                         partial: 'admin/editor/deal_sections/deal_section',
                         locals: { deal_section: deal_section, deal: self })
  end

  def broadcast_preview_destroy(deal_section)
    broadcast_remove_to(self, :deal_sections_preview, target: dom_id(deal_section))
  end

  private

  def generate_uuid()
    SecureRandom.uuid
  end
end
