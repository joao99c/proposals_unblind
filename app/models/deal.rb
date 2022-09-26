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
    deal_sections << DealSection.new({
                                       deal_id: id,
                                       section_id: 1,
                                       preHeading: 'Pre Cabeçalho',
                                       heading: 'Cabeçalho',
                                       subHeading: 'Sub Cabeçalho',
                                       theme: {
                                         name: 'none',
                                         colors: {
                                           background: '#ffffff',
                                           button: '#4b2aad',
                                           buttonText: '#ffffff',
                                           heading: '#0d161b',
                                           text: '#0d161b'
                                         },
                                         background: {
                                           blend: 'normal',
                                           blur: 0,
                                           contrast: 75,
                                           grayscale: 100,
                                           opacity: 38,
                                           url: nil
                                         }
                                       },
                                       button: {
                                         text: 'Button',
                                         url: 'https://www.google.com'
                                       },
                                       button2: {
                                         text: 'Button 2',
                                         url: 'https://www.google.com'
                                       },
                                       links: {
                                         twitter: {
                                           position: 0,
                                           name: 'twitter',
                                           url: '1'
                                         },
                                         facebook: {
                                           position: 1,
                                           name: 'facebook',
                                           url: '1'
                                         },
                                         instagram: {
                                           position: 2,
                                           name: 'instagram',
                                           url: '1'
                                         },
                                         pinterest: {
                                           position: 3,
                                           name: 'pinterest',
                                           url: '1'
                                         },
                                         linkedin: {
                                           position: 4,
                                           name: 'linkedin',
                                           url: '1'
                                         },
                                         youtube: {
                                           position: 5,
                                           name: 'youtube',
                                           url: '1'
                                         },
                                         tiktok: {
                                           position: 6,
                                           name: 'tiktok',
                                           url: '1'
                                         },
                                         website: {
                                           position: 7,
                                           name: 'website',
                                           url: '1'
                                         },
                                         mailto: {
                                           position: 8,
                                           name: 'mailto',
                                           url: 'mailto:1'
                                         }
                                       },
                                       buttonSubtext: 'Button Subtext',
                                       text: 'Im a text',
                                       mediaAlignment: 'left', # left, center, right ...
                                       mediaStyle: 'plain' # plain, card ...
                                     })
    deal_sections << DealSection.new({
                                       deal_id: id,
                                       section_id: 2,
                                       preHeading: 'Pre Propostas',
                                       heading: 'Propostas',
                                       subHeading: 'Sub Propostas',
                                       theme: {
                                         name: 'none',
                                         colors: {
                                           background: '#ffffff',
                                           button: '#4b2aad',
                                           buttonText: '#ffffff',
                                           heading: '#0d161b',
                                           text: '#0d161b'
                                         },
                                         background: {
                                           blend: 'normal',
                                           blur: 0,
                                           contrast: 75,
                                           grayscale: 100,
                                           opacity: 38,
                                           url: nil
                                         }
                                       },
                                       button: {
                                         text: 'Button',
                                         url: 'https://www.google.com'
                                       },
                                       button2: {
                                         text: 'Button 2',
                                         url: 'https://www.google.com'
                                       },
                                       links: {
                                         twitter: {
                                           position: 0,
                                           name: 'twitter',
                                           url: '1'
                                         },
                                         facebook: {
                                           position: 1,
                                           name: 'facebook',
                                           url: '1'
                                         },
                                         instagram: {
                                           position: 2,
                                           name: 'instagram',
                                           url: '1'
                                         },
                                         pinterest: {
                                           position: 3,
                                           name: 'pinterest',
                                           url: '1'
                                         },
                                         linkedin: {
                                           position: 4,
                                           name: 'linkedin',
                                           url: '1'
                                         },
                                         youtube: {
                                           position: 5,
                                           name: 'youtube',
                                           url: '1'
                                         },
                                         tiktok: {
                                           position: 6,
                                           name: 'tiktok',
                                           url: '1'
                                         },
                                         website: {
                                           position: 7,
                                           name: 'website',
                                           url: '1'
                                         },
                                         mailto: {
                                           position: 8,
                                           name: 'mailto',
                                           url: 'mailto:1'
                                         }
                                       },
                                       buttonSubtext: 'Button Subtext',
                                       text: 'Im a text',
                                       mediaAlignment: 'left', # left, center, right ...
                                       mediaStyle: 'plain' # plain, card ...
                                     })
    deal_sections << DealSection.new({
                                       deal_id: id,
                                       section_id: 3,
                                       preHeading: nil,
                                       heading: 'Contacte-nos',
                                       text: 'Deliver great service experiences fast - without the complexity of traditional ITSM solutions.Accelerate critical development work, eliminate toil, and deploy changes with ease.',
                                       subHeading: nil,
                                       theme: {
                                         name: 'none',
                                         colors: {
                                           background: '#ffffff',
                                           button: '#4b2aad',
                                           buttonText: '#ffffff',
                                           heading: '#0d161b',
                                           text: '#0d161b'
                                         },
                                       },
                                       button: {
                                         text: 'Button',
                                         url: 'https://www.google.com'
                                       },
                                       buttonSubtext: nil,
                                       mediaAlignment: 'left', # left, center, right ...
                                       mediaStyle: 'plain' # plain, card ...
                                     })
    save!
  end
end
