# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show]

  def likes
    @liked_reviews = current_user.liked_reviews
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    # 総合投稿数
    @total_reviews_count = @user.reviews.count
    # 今月の投稿数
    @monthly_reviews_count = @user.reviews.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month).count
    # 称号の更新（必要に応じて）
    @user.update_review_stats if @user.reviews.any?
    # そのユーザーが投稿したレビューのみを取得
    @received_likes_count = @user.reviews.sum(:likes_count)
    @reviews = @user.reviews.includes(:main_images).order(created_at: :desc).page(params[:page]).per(10)
  end

  def titles
    @user = User.find(params[:id])
  end

  def likes
    @liked_reviews = current_user.liked_reviews.includes(:user, :main_images).order(created_at: :desc).page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname)
  end
end
