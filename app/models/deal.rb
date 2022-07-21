class Deal < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  # kaminari
  paginates_per 10

  def self.index_methods
    %i[id user_id customer_id]
  end

  def self.show_lists
    []
  end

  def self.filter_methods
    %i[id user_id customer_id]
  end

  ransacker :id do
    Arel.sql("to_char(\"#{self.table_name}\".\"id\", '99999999')")
  end
  ransacker :user_id do
    Arel.sql("to_char(\"#{self.table_name}\".\"user_id\", '99999999')")
  end
  ransacker :customer_id do
    Arel.sql("to_char(\"#{self.table_name}\".\"customer_id\", '99999999')")
  end
end
