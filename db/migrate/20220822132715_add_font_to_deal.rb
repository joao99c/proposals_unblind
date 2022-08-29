class AddFontToDeal < ActiveRecord::Migration[7.0]
  def change
    add_reference :deals, :text_typeface, foreign_key: { to_table: :fonts }, default: 1
    add_column :deals, :text_weight, :text, default: 700
    add_column :deals, :text_spacing, :text, default: 0
    add_column :deals, :text_height, :text, default: 1.2

    add_reference :deals, :heading_typeface, foreign_key: { to_table: :fonts }, default: 1
    add_column :deals, :heading_weight, :text, default: 400
    add_column :deals, :heading_spacing, :text, default: 0
    add_column :deals, :heading_height, :text, default: 1.35
  end
end
