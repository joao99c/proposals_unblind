class Customer < ApplicationRecord
  include Admin::AdminResource

  has_many :deals, dependent: :destroy

  has_one_attached :logo

  ransacker :reversed_name, type: :string, formatter: proc { |v| v.reverse } do |parent|
    parent.table[:name]
  end

  paginates_per 5

  column :id
  column :name
  column :email

  def self.filter_methods
    %i[id name email]
  end

  ransacker :id do
    Arel.sql("to_char(\"#{self.table_name}\".\"id\", '99999999')")
  end
end
