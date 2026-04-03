class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # 環境に応じて storage を切り替える
  if Rails.env.production?
    storage :fog  # 本番環境ではクラウドストレージ
  else
    storage :file # 開発環境・テスト環境ではローカル保存
  end

  process resize_to_fit: [300, 300]

  def default_url
   "E51711FC-56D8-431F-B2C9-04124182C753.jpeg"
  end

  def fog_authenticated_url_expiration
    5.weeks.to_i # URLの有効期限を5週間に設定
  end
