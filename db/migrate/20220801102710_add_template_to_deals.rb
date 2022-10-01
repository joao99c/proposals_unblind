class AddTemplateToDeals < ActiveRecord::Migration[7.0]
  def change
    add_reference :deals, :template, null: true, foreign_key: true
  end
end
