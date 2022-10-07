class AddButtonDesignToDeals < ActiveRecord::Migration[7.0]
  def change
    add_column :deals, :button_background_color, :string
    add_column :deals, :button_border_color, :string
    add_column :deals, :button_border_width, :string
    add_column :deals, :button_border_radius, :string
  end
end
