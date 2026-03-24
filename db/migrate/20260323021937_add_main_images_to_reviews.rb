class AddMainImagesToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :main_images, :string
  end
end
