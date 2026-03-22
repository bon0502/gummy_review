class CreateFlavorGummies < ActiveRecord::Migration[7.0]
  def change
    create_table :flavor_gummies do |t|
      t.references :flavor, null: false, foreign_key: true
      t.references :gummy, null: false, foreign_key: true

      t.timestamps
    end
    add_index :flavor_gummies, [:flavor_id, :gummy_id], unique: true
  end
end
