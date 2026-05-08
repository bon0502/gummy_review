class AddCacheColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reviews_count, :integer, default: 0, null: false
    add_column :users, :avg_sweetness, :decimal, precision: 3, scale: 2, default: 0.0
    add_column :users, :avg_sourness, :decimal, precision: 3, scale: 2, default: 0.0
    add_column :users, :avg_hardness, :decimal, precision: 3, scale: 2, default: 0.0
    add_column :users, :unique_gummies_count, :integer, default: 0, null: false

    # インデックスを追加（検索の高速化）
    add_index :users, :reviews_count
  end
end
