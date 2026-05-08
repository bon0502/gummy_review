# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :main_images, dependent: :destroy

  mount_uploader :photo_url, PhotoUploader
  # mount_uploaders :main_images, PhotoUploader

  accepts_nested_attributes_for :main_images, allow_destroy: true

  validates :gummy_name, :flavor, :rating, :sweetness, :sourness, :hardness, presence: true

  after_commit :update_user_stats, on: [:create, :update, :destroy]
  after_commit :clear_user_cache, on: [:create, :update, :destroy]

  def self.ransackable_attributes(_auth_object = nil)
    %w[comment flavor gummy_name hardness id purchase_location rating sourness sweetness
       updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[comments user]
  end

  def sweetness_label
    case sweetness
    when 1 then 'とても甘い'
    when 2 then '少し甘い'
    when 3 then '甘い'
    when 4 then '甘さ控えめ'
    when 5 then '甘くない'
    else '不明'
    end
  end

  def sourness_label
    case sourness
    when 1 then '酸っぱくない'
    when 2 then '酸っぱさ控えめ'
    when 3 then '酸っぱい'
    when 4 then '少し酸っぱい'
    when 5 then 'とても酸っぱい'
    else '不明'
    end
  end

  def hardness_label
    case hardness
    when 1 then 'とてもソフト'
    when 2 then 'ソフト'
    when 3 then '普通'
    when 4 then 'ハード'
    when 5 then 'とてもハード'
    else '不明'
    end
  end

  private

  def update_user_stats
    user.update_review_stats
  end

  def clear_user_cache
    Rails.cache.delete("user_#{user_id}_activity_titles")
  end
end
