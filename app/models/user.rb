class User < ApplicationRecord
  include Admin::AdminResource
  has_many :deals

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  ransacker :reversed_name, type: :string, formatter: proc { |v| v.reverse } do |parent|
    parent.table[:name]
  end

  # kaminari
  paginates_per 5

  # Index Table
  column :id, class: 'some-class another-class'
  column :name, class: 'some-class another-class'
  column :email, class: 'some-class another-class'

  def self.filter_methods
    %i[id name email]
  end

  ransacker :id do
    Arel.sql("to_char(\"#{self.table_name}\".\"id\", '99999999')")
  end

  private

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
