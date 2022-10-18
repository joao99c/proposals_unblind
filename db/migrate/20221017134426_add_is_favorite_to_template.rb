class AddIsFavoriteToTemplate < ActiveRecord::Migration[7.0]
  def change
    add_column :templates, :isFavorite, :boolean, default: false
  end
end
