class AddChildBooleanToDealSections < ActiveRecord::Migration[7.0]
  def change
    add_column :deal_sections, :child, :boolean, default: false
  end
end
