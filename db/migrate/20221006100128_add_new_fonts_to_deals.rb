class AddNewFontsToDeals < ActiveRecord::Migration[7.0]
  def change
    %w[section_heading sub_section_heading link button].map do |item|
      add_reference :deals, "#{item}_typeface", foreign_key: { to_table: :fonts }, default: 1
      add_column :deals, "#{item}_weight", :text, default: 400
      add_column :deals, "#{item}_spacing", :text, default: 0
      add_column :deals, "#{item}_height", :text, default: 1.2
    end
  end
end
