class CreateMainImages < ActiveRecord::Migration[7.0]
  def change
    create_table :main_images do |t|
      t.references :review, null: false, foreign_key: true
      t.string :image

      t.timestamps
    end
  end
end
