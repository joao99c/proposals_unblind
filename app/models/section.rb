class Section < ApplicationRecord
  has_many :deal_sections, -> { order(position: :asc) }, dependent: :destroy
  belongs_to :section_category

  def is_text?
    name == 'text'
  end

  def is_bio?
    name == 'bio'
  end

  def is_grid?
    name == 'grid'
  end
end
