class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.text :website

      t.string :responsable_name
      t.string :responsable_email
      t.text :responsable_tel

      t.timestamps
    end
  end
end
