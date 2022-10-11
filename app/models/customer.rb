class Customer < ApplicationRecord
  before_save :normalize_phone

  acts_as_tenant(:user)

  include Admin::AdminResource

  has_many :deals, dependent: :destroy

  has_one_attached :logo

  validates :responsable_tel, phone: true, allow_blank: false
  validates_presence_of :name, :responsable_email, :responsable_name

  def formatted_phone
    parsed_phone = Phonelib.parse(responsable_tel)
    return responsable_tel if parsed_phone.invalid?

    formatted =
      if parsed_phone.country_code == "351" # NANP
        parsed_phone.full_national # (415) 555-2671;123
      else
        parsed_phone.full_international # +44 20 7183 8750
      end
    formatted.gsub!(";", " x") # (415) 555-2671 x123
    formatted
  end

  private
  def normalize_phone
    self.responsable_tel = Phonelib.parse(responsable_tel).full_e164.presence
  end
end
