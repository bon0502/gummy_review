class Admin::DashboardsController < Admin::BaseController
  def index
    @users_count = User.count
    @reviews_count = Review.count
    @recent_reviews = Review.includes(:user).order(created_at: :desc).limit(5)
  end
end
