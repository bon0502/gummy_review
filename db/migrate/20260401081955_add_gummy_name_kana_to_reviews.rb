class AddGummyNameKanaToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :gummy_name_kana, :string
  end
end
