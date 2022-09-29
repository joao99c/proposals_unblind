# frozen_string_literal: true

class Deal < ApplicationRecord
  IVA = 0.23
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

  belongs_to :user, optional: true

  belongs_to :customer, optional: true
  accepts_nested_attributes_for :customer

  has_many :deal_sections, -> { order(position: :asc).where(child: false) }, dependent: :destroy
  accepts_nested_attributes_for :deal_sections, allow_destroy: true, reject_if: :all_blank

  belongs_to :heading_typeface, class_name: 'Font', foreign_key: 'heading_typeface_id'
  belongs_to :text_typeface, class_name: 'Font', foreign_key: 'text_typeface_id'

  # Validations
  validates :name, presence: true

  after_create_commit :create_cabecalho_propostas_and_contacto_section

  def total_amount
    total_subtotal - total_discount + total_iva
  end

  def total_iva
    total_subtotal * IVA
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
    deal_sections.where(section_id: 1).first
  end

  def section_propostas
    deal_sections.where(section_id: 2).first
  end

  private

  def create_cabecalho_propostas_and_contacto_section
    deal_sections << Admin::Editor::HeadingSection.new
    deal_sections << Admin::Editor::ProposalSection.new
    deal_sections << Admin::Editor::ContactSection.new

    save!
  end
end
