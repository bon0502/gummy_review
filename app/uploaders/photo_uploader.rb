# frozen_string_literal: true

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # 環境に応じて storage を切り替える
  if Rails.env.production?
    storage :fog  # 本番環境ではクラウドストレージ
  else
    storage :file # 開発環境・テスト環境ではローカル保存
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # ⭐️ resize_to_limit を使用（より安全）
  process resize_to_limit: [300, 300]

  def extension_allowlist
    %w[jpg jpeg gif png]
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("gummy.jpeg")
  end
end
