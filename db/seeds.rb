# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# 管理者ユーザーがまだ存在しない場合のみ作成
if Rails.env.production?
  # 本番環境では環境変数を必須にする
  if ENV['ADMIN_PASSWORD'].blank?
    puts "⚠️  ADMIN_PASSWORD環境変数が設定されていません"
    exit 1
  end
end

if AdminUser.count.zero?
  AdminUser.create!(
    name: 'Admin',
    email: ENV['ADMIN_EMAIL'] || 'admin@example.com',
    password: ENV['ADMIN_PASSWORD'],
    password_confirmation: ENV['ADMIN_PASSWORD']
  )
  puts "✅ 管理者ユーザーを作成しました"
else
  puts "ℹ️  管理者ユーザーは既に存在します"
end
