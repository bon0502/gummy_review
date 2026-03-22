class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :gummy, null: false, foreign_key: true
      t.integer :rating, null: false
      t.string :purchase_location
      t.string :photo_url
      t.integer :sweetness
      t.integer :sourness
      t.integer :hardness
      t.text :comment

      t.timestamps
    end
  end
end
