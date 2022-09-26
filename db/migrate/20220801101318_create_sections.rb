class CreateSections < ActiveRecord::Migration[7.0]
  def change
    create_table :sections do |t|
      t.string :name
      t.references :section_type, null: false, foreign_key: true
      t.references :section_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
