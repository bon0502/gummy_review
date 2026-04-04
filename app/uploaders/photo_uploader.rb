# frozen_string_literal: true

class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # 環境に応じて storage を切り替える
  if Rails.env.production?
    storage :fog  # 本番環境ではクラウドストレージ
  else
    storage :file # 開発環境・テスト環境ではローカル保存
  end

  # ⭐️ store_dir を明示的に指定
  def store_dir
    'uploads' # public/ からの相対パスを指定
  end

  process resize_to_fit: [300, 300]

  def default_url
    'E51711FC-56D8-431F-B2C9-04124182C753.jpeg'
  end

  # ⭐️ filename メソッドを修正
  def filename
    return if original_filename.blank?

    # 拡張子を .jpg に統一
    @filename ||= "#{SecureRandom.uuid}.jpg"
  end
end
