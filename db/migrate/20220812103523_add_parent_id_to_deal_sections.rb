class AddParentIdToDealSections < ActiveRecord::Migration[7.0]
  def change
    add_column :deal_sections, :parent_id, :integer, null: true
  end
end
