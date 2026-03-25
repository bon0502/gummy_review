class ChangeMainImagesToJsonInReviews < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :main_images, :json, using: 'main_images::json'
  end
end
