class AddFlavorKanaToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :flavor_kana, :string
  end
end
