class CreateDealSectionItems < ActiveRecord::Migration[7.0]
  def change
    create_table :deal_section_items do |t|
      t.references :parent, foreign_key: { to_table: :deal_sections }
      t.references :child, foreign_key: { to_table: :deal_sections }
      t.integer :position

      t.timestamps
    end
  end
end
