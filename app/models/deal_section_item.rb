class DealSectionItem < ApplicationRecord
  acts_as_list scope: :parent, sequential_updates: false

  belongs_to :parent, class_name: 'DealSection'
  belongs_to :child, class_name: 'DealSection', dependent: :destroy
  accepts_nested_attributes_for :child, allow_destroy: true
end
