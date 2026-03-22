class AddSweetnessSournessHardnessToGummies < ActiveRecord::Migration[7.0]
  def change
    add_column :gummies, :sweetness, :integer
    add_column :gummies, :sourness, :integer
    add_column :gummies, :hardness, :integer
  end
end
