# frozen_string_literal: true

class Tagging < ApplicationRecord
  belongs_to :deal
  belongs_to :tag
end
