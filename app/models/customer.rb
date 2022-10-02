class Customer < ApplicationRecord
  acts_as_tenant(:user)

  include Admin::AdminResource

  has_many :deals, dependent: :destroy

  has_one_attached :logo

  validates_presence_of :name, :website, :responsable_email, :responsable_name, :responsable_tel
end
