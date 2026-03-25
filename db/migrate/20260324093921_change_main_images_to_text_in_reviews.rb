class ChangeMainImagesToTextInReviews < ActiveRecord::Migration[7.0]
  def change
    change_column :reviews, :main_images, :text
  end
end
