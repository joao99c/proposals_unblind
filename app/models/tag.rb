# frozen_string_literal: true

COLORS = [
  { name: 'gray', color_info: { color: 'gray-800', background_color: 'gray-100' } },
  { name: 'green', color_info: { color: 'green-800', background_color: 'green-100' } },
  { name: 'blue', color_info: { color: 'blue-800', background_color: 'blue-100' } },
  { name: 'indigo', color_info: { color: 'indigo-800', background_color: 'indigo-100' } },
  { name: 'purple', color_info: { color: 'purple-800', background_color: 'purple-100' } },
].freeze

class Tag < ApplicationRecord
  acts_as_tenant(:user)

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  validates :name, presence: true, uniqueness: true

  before_create :generate_random_color

  def text_color
    get_color[:color_info][:color]
  end

  def background_color
    get_color[:color_info][:background_color]
  end

  private

  def get_color
    COLORS.find { |color| color[:name].to_s == self.color }
  end

  def generate_random_color
    self.color = COLORS.sample[:name]
  end
end
