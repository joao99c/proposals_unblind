class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, :email, :responsable_name, :responsable_email
      t.text :website, :responsable_tel

      t.timestamps
    end
  end
end
