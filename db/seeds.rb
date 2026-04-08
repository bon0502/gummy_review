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
  if ENV['ADMIN_PASSWORD'].blank?
    puts "⚠️  ADMIN_PASSWORD環境変数が設定されていません"
    exit 1
  end

  if ENV['ADMIN_PASSWORD'].length < 8
    puts "⚠️  ADMIN_PASSWORDは8文字以上にしてください"
    exit 1
  end
end

if AdminUser.count.zero?
  admin = AdminUser.new(
    name: 'Admin',
    email: ENV['ADMIN_EMAIL'] || 'admin@example.com',
    password: ENV['ADMIN_PASSWORD'] || 'SecurePassword123!',
    password_confirmation: ENV['ADMIN_PASSWORD'] || 'SecurePassword123!'
  )

  if admin.save
    puts "✅ 管理者ユーザーを作成しました"
    puts "   Email: #{admin.email}"
  else
    puts "❌ 管理者ユーザーの作成に失敗しました"
    puts admin.errors.full_messages.join("\n")
    exit 1
  end
else
  puts "ℹ️  管理者ユーザーは既に存在します（#{AdminUser.count}人）"
end
