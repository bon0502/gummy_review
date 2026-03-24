class AddGummyNameToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :gummy_name, :string
  end
end
