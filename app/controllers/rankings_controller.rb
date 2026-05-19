class RankingsController < ApplicationController
  def index
    @reviews = Review.all.order(created_at: :desc)
    # ランキングデータを取得（上位5名）
    @ranking_users = User.monthly_ranking(limit: 5)
  end
end
