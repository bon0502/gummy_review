class AddStatsToUsersV2 < ActiveRecord::Migration[7.0]
  def change
    # カラムが存在しない場合のみ追加
    add_column :users, :avg_sweetness, :decimal, precision: 3, scale: 2, default: 0.0 unless column_exists?(:users, :avg_sweetness)
    add_column :users, :avg_sourness, :decimal, precision: 3, scale: 2, default: 0.0 unless column_exists?(:users, :avg_sourness)
    add_column :users, :avg_hardness, :decimal, precision: 3, scale: 2, default: 0.0 unless column_exists?(:users, :avg_hardness)
    add_column :users, :unique_gummies_count, :integer, default: 0 unless column_exists?(:users, :unique_gummies_count)
  end
end
