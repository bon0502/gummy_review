class AddOverallRatingToGummies < ActiveRecord::Migration[7.0]
  def change
    add_column :gummies, :overall_rating, :integer, null: false, default: 0
  end
end
