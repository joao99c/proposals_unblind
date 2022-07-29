# frozen_string_literal: true

class Deal < ApplicationRecord
  include Admin::AdminResource

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

  belongs_to :user, optional: true

  belongs_to :customer, optional: true
  accepts_nested_attributes_for :customer

  # Validations
  validates :name, presence: true
  validates :user, :customer, presence: true, on: :update

  # kaminari
  paginates_per 10

  # Table columns
  column :name, { sortable: false }
  column :customer, { sortable: false }
  column :user, { sortable: false }
  column :total_amount, { sortable: false }
  column :finish_date, { sortable: false }

  def update_total_amount
    self.total_amount = deal_products.map(&:price).sum
    save
  end
end
