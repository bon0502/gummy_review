class Admin::DashboardsController < ApplicationController
  before_action :require_login
  before_action :check_admin

  def index
    @users_count = User.count
    @reviews_count = Review.count
    @recent_reviews = Review.includes(:user).order(created_at: :desc).limit(5)
  end

  private

  def check_admin
    redirect_to root_path, alert: '管理者のみアクセスできます' unless current_user.admin?
  end
end
