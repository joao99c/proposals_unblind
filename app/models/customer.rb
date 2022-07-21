class Customer < ApplicationRecord

  has_many :deals, counter_cache: true

  ransacker :reversed_name, type: :string, formatter: proc { |v| v.reverse } do |parent|
    parent.table[:name]
  end


  def self.index_methods
    %i[id name email]
  end

  def self.show_lists
    []
  end

  def self.filter_methods
    %i[id name email]
  end

  ransacker :id do
    Arel.sql("to_char(\"#{self.table_name}\".\"id\", '99999999')")
  end
end
