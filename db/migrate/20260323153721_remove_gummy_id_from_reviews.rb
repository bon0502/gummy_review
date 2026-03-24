class RemoveGummyIdFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :gummy_id, :bigint
  end
end
