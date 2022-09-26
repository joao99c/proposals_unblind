class CreateDeals < ActiveRecord::Migration[7.0]
  def change
    create_enum :deal_status, %w[lost open won]
    create_table :deals do |t|
      t.string :name
      t.decimal :total_discount, precision: 10, scale: 2, default: 0.0, null: true
      t.decimal :total_subtotal, precision: 10, scale: 2, default: 0.0, null: true
      t.datetime :finish_date
      t.datetime :send_date

      t.enum :status, enum_type: :deal_status, default: :open, null: false

      t.references :user, null: true, foreign_key: true
      t.references :customer, null: true, foreign_key: true

      t.timestamps
    end
  end
end
