class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.string :color, null: false
      t.timestamps

      t.references :user, null: true, foreign_key: true
    end
  end
end