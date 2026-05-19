# frozen_string_literal: true

class User < ApplicationRecord
  authenticates_with_sorcery!

  enum role: { general: 0, admin: 1 }

  mount_uploader :avatar, AvatarUploader

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_reviews, through: :likes, source: :review

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :nickname, presence: true, length: { maximum: 255 }

  def own?(object)
    id == object.user_id
  end

  # ========================================
  # ここから称号機能のコードを追加
  # ========================================

  # すべての称号を取得（メインメソッド）
  def all_titles
    [
      current_title,                # 現在の称号
      *taste_preference_titles,     # 味の傾向
      *activity_and_time_titles     # 活動頻度・時間帯（キャッシュ）
    ].compact
  end

    # すべての称号を種類ごとに配列で返すメソッド
  def all_titles_with_type
    titles = []

    # レビュー数による称号(青色)
    if current_title.present?
      titles << { title: current_title, type: 'primary' }
    end

    # 味の傾向による称号(緑色)
    taste_preference_titles.each do |title|
      titles << { title: title, type: 'success' }
    end

    # 活動頻度・時間帯による称号(黄色)
    activity_and_time_titles.each do |title|
      titles << { title: title, type: 'warning' }
    end

    titles
  end

  # レビュー数に応じた称号（DBのカウンターキャッシュを使用）
  def current_title
    case reviews_count
    when 800.. then "グミの変態"
    when 500.. then "グミの神"
    when 100.. then "グミマスター"
    when 50.. then "グミマニア"
    when 10.. then "グミ好き"
    when 1.. then "グミ初心者"
    else "グミ見習い"
    end
  end

  # 味の傾向に応じた称号（DBの平均値を使用）
  def taste_preference_titles
    titles = []
    titles << "甘党" if avg_sweetness >= 4.0
    titles << "酸っぱいグミ好き" if avg_sourness >= 4.0
    titles << "ハードグミ好き" if avg_hardness >= 4.0
    titles << "ソフトグミ好き" if avg_hardness <= 2.0
    titles
  end

  # 活動頻度・時間帯の称号（Railsキャッシュを使用）
  def activity_and_time_titles
    Rails.cache.fetch("user_#{id}_activity_titles", expires_in: 1.hour) do
      calculate_activity_and_time_titles
    end
  end

  # 平均値とユニーク数を更新
  def update_review_stats
    update_columns(
      avg_sweetness: reviews.average(:sweetness)&.round(2) || 0.0,
      avg_sourness: reviews.average(:sourness)&.round(2) || 0.0,
      avg_hardness: reviews.average(:hardness)&.round(2) || 0.0,
      unique_gummies_count: reviews.distinct.count(:gummy_name)
    )
  end

    # 当月の投稿数を取得
  def monthly_review_count
    reviews.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month).count
  end

  # 月次ランキングを取得（クラスメソッド）
  def self.monthly_ranking(limit: 10)
    joins(:reviews)
      .where(reviews: { created_at: Time.current.beginning_of_month..Time.current.end_of_month })
      .group('users.id')
      .select('users.*, COUNT(reviews.id) as review_count')
      .order('review_count DESC')
      .limit(limit)
  end

  private

  # 複雑な計算ロジック（キャッシュされる）
  def calculate_activity_and_time_titles
    titles = []

    # 今月の投稿数
    this_month_count = reviews.where(
      created_at: Time.current.beginning_of_month..Time.current.end_of_month
    ).count
    titles << "月間アクティブ" if this_month_count >= 10

    # 連続投稿日数
    consecutive_days = calculate_consecutive_days
    titles << "継続の鬼" if consecutive_days >= 30
    titles << "毎日投稿" if consecutive_days >= 7

    # 時間帯別称号
    titles.concat(calculate_time_based_titles)

    # グミコレクター
    titles << "グミコレクター" if unique_gummies_count >= 50

    titles
  end

  # 連続投稿日数を計算
  def calculate_consecutive_days
    return 0 if reviews.empty?

    review_dates = reviews.order(created_at: :desc)
                         .pluck(:created_at)
                         .map(&:to_date)
                         .uniq

    consecutive = 1
    max_consecutive = 1

    review_dates.each_cons(2) do |current, previous|
      if (previous - current).to_i == 1
        consecutive += 1
        max_consecutive = [max_consecutive, consecutive].max
      else
        consecutive = 1
      end
    end

    max_consecutive
  end

    # 時間帯別称号を計算
  def calculate_time_based_titles
    titles = []

    # PostgreSQLの場合
    time_counts = {
      "早起きグミラー" => reviews.where("EXTRACT(HOUR FROM created_at) BETWEEN 3 AND 5").count,
      "シャキッとグミラー" => reviews.where("EXTRACT(HOUR FROM created_at) BETWEEN 6 AND 11").count,
      "日中活動中のグミラー" => reviews.where("EXTRACT(HOUR FROM created_at) BETWEEN 12 AND 17").count,
      "黄昏のグミラー" => reviews.where("EXTRACT(HOUR FROM created_at) BETWEEN 18 AND 19").count,
      "ナイトグミラー" => reviews.where("EXTRACT(HOUR FROM created_at) BETWEEN 20 AND 23").count,
      "夜更かしグミラー" => reviews.where("EXTRACT(HOUR FROM created_at) BETWEEN 0 AND 2").count
    }

    # 最も投稿が多い時間帯の称号を追加
    max_time_count = time_counts.max_by { |_, count| count }
    titles << max_time_count[0] if max_time_count && max_time_count[1] > 5

    titles
  end
end
