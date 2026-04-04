# frozen_string_literal: true

class Gummy < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :maker
  has_many :flavor_gummies, dependent: :destroy
  has_many :flavors, through: :flavor_gummies

  attr_accessor :manufacturer_name

  before_validation :assign_maker

  def assign_maker
    return if manufacturer_name.blank?

    self.maker = Maker.find_by(name: manufacturer_name)
  end

  def sweetness_label
    case sweetness
    when 1
      'かなり甘い'
    when 2
      '少し甘い'
    when 3
      '甘い'
    when 4
      '甘さ控えめ'
    when 5
      '甘くない'
    else
      '不明'
    end
  end

  def sourness_label
    case sourness
    when 1
      '酸っぱくない'
    when 2
      '酸っぱさ控えめ'
    when 3
      '酸っぱい'
    when 4
      '少し酸っぱい'
    when 5
      'かなり酸っぱい'
    else
      '不明'
    end
  end

  def hardness_label
    case hardness
    when 1
      'かなりソフト'
    when 2
      'ソフト'
    when 3
      '普通'
    when 4
      'ハード'
    when 5
      'かなりハード'
    else
      '不明'
    end
  end
end
