class SectionType < ApplicationRecord
  has_many :sections, dependent: :destroy
end
