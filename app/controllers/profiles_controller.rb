# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update update_password]

  def show
    @user = current_user
    # 総合投稿数
    @total_reviews_count = @user.reviews.count

    # 今月の投稿数
    @monthly_reviews_count = @user.reviews.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month).count

    if @monthly_reviews_count > 0
      @monthly_avg_hardness = @user.reviews.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month).average(:hardness).to_f.round(1)
      @monthly_avg_sweetness = @user.reviews.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month).average(:sweetness).to_f.round(1)
      @monthly_avg_sourness = @user.reviews.where(created_at: Time.current.beginning_of_month..Time.current.end_of_month).average(:sourness).to_f.round(1)
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if current_user.update(profile_params)
      redirect_to profile_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def update_password
    # 現在のパスワードが正しいかチェック
    unless @user.valid_password?(params[:user][:current_password])
      flash.now[:danger] = '現在のパスワードが正しくありません'
      render :edit, status: :unprocessable_entity
      return
    end

    # 新しいパスワードで更新
    if @user.update(password_params)
      redirect_to profile_path, success: 'パスワードを変更しました'
    else
      flash.now[:danger] = 'パスワードの変更に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def profile_params
    params.require(:user).permit(:email, :nickname, :avatar)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
