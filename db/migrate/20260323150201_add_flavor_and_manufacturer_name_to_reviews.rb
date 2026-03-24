class AddFlavorAndManufacturerNameToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :flavor, :string
    add_column :reviews, :manufacturer_name, :string
  end
end
