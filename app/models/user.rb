class User < ApplicationRecord
  has_many :deals
  has_many :templates, -> { where(isFavorite: true) }
  has_many :customers
  has_many :products

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_one_attached :company_avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  after_create_commit :create_my_template

  def name
    if first_name.present? && last_name.present?
      "#{first_name} #{last_name}"
    else
      "#{email}"
    end
  end

  private

  def create_my_template
    templates << Template.new(name: "Template Geral", user: self)
    save
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.avatar_url = auth.info.image
    end
  end
end
