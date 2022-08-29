class AddFontToDeal < ActiveRecord::Migration[7.0]
  def change
    add_reference :deals, :text_typeface, foreign_key: { to_table: :fonts }
    add_column :deals, :text_weight, :text
    add_column :deals, :text_spacing, :text
    add_column :deals, :text_height, :text

    add_reference :deals, :heading_typeface, foreign_key: { to_table: :fonts }
    add_column :deals, :heading_weight, :text
    add_column :deals, :heading_spacing, :text
    add_column :deals, :heading_height, :text
  end
end
