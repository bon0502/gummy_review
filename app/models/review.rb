class Review < ApplicationRecord
  belongs_to :user
  # belongs_to :gummy
  mount_uploader :photo_url, PhotoUploader
  mount_uploaders :main_images, PhotoUploader

  validates :gummy_name, :flavor, :rating, :sweetness, :sourness, :hardness, presence: true

  def sweetness_label
    case sweetness
    when 1
      "とても甘い"
    when 2
      "少し甘い"
    when 3
      "甘い"
    when 4
      "甘さ控えめ"
    when 5
      "甘くない"
    else
      "不明"
    end
  end

  def sourness_label
    case sourness
    when 1
      "酸っぱくない"
    when 2
      "酸っぱさ控えめ"
    when 3
      "酸っぱい"
    when 4
      "少し酸っぱい"
    when 5
      "とても酸っぱい"
    else
      "不明"
    end
  end

  def hardness_label
    case hardness
    when 1
      "とてもソフト"
    when 2
      "ソフト"
    when 3
      "普通"
    when 4
      "ハード"
    when 5
      "とてもハード"
    else
      "不明"
    end
  end
end
