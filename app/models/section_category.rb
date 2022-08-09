class SectionCategory < ApplicationRecord
  default_scope { order(:position) }

  has_many :sections, dependent: :destroy
end
