# frozen_string_literal: true

class GummiesController < ApplicationController
  def index
    @gummies = Gummy.all.order(created_at: :desc)
    # ランキングデータも取得（上位5名程度）
    @ranking_users = Rails.cache.fetch('monthly_ranking', expires_in: 5.minutes) do
      User.monthly_ranking(limit: 5)
    end
  end
end
