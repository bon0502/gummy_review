class CreateGummies < ActiveRecord::Migration[7.0]
  def change
    create_table :gummies do |t|
      t.string :photo_url
      t.string :name
      t.references :maker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
