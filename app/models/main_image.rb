class MainImage < ApplicationRecord
  belongs_to :review
  mount_uploader :image, PhotoUploader

    # ⭐️ image= メソッドをオーバーライド
  def image=(value)
    if value.is_a?(Array)
      # 配列の場合、空文字列を除外して最初の有効な要素のみを使用
      valid_value = value.reject(&:blank?).first
      super(valid_value)
    else
      super(value)
    end
  end

  validates :image, presence: true
end
