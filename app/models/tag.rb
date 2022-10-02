# frozen_string_literal: true

COLORS = [
  # { name: :red, color_info: { color: '#9B1C1C', background_color: '#FDE8E8' } },
  # { name: :green, color_info: { color: '#03543F', background_color: '#DEF7EC' } },
  # { name: :blue, color_info: { color: '#1E429F', background_color: '#E1EFFE' } },
  # { name: :yellow, color_info: { color: '#723B13', background_color: '#FDF6B2' } },
  # { name: :gray, color_info: { color: '#1F2937', background_color: '#F3F4F6' } },
  # { name: :indigo, color_info: { color: '#42389D', background_color: '#E5EDFF' } },
  # { name: :violet, color_info: { color: '#621c9b', background_color: '#f6e8fd' } },
  # { name: :maroon, color_info: { color: '#9b4d1c', background_color: '#fde8e8' } },
  # { name: :lime, color_info: { color: '#6f9b1c', background_color: '#effde8' } },
  # { name: :aqua, color_info: { color: '#1c9b88', background_color: '#e8fdf9' } }

  { name: 'gray', color_info: { color: 'gray-800', background_color: 'gray-100' } },
  { name: 'red', color_info: { color: 'red-800', background_color: 'red-100' } },
  { name: 'yellow', color_info: { color: 'yellow-800', background_color: 'yellow-100' } },
  { name: 'green', color_info: { color: 'green-800', background_color: 'green-100' } },
  { name: 'blue', color_info: { color: 'blue-800', background_color: 'blue-100' } },
  { name: 'indigo', color_info: { color: 'indigo-800', background_color: 'indigo-100' } },
  { name: 'purple', color_info: { color: 'purple-800', background_color: 'purple-100' } },
  { name: 'pink', color_info: { color: 'pink-800', background_color: 'pink-100' } }
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
