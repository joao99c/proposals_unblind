class CreateDealProducts < ActiveRecord::Migration[7.0]
  def change
    create_enum :discount_type, %w[none percent fixed free]
    create_table :deal_products do |t|
      t.references :deal, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.decimal :discount_amount, precision: 10, scale: 2, default: 0.0, null: false
      t.enum :discount_type, enum_type: :discount_type, default: :none, null: false
      t.integer :quantity

      t.timestamps
    end
  end
end
