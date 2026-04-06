# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :require_login
  add_flash_types :success, :danger

  private

  def not_authenticated
    redirect_to login_path
  end

  def current_user
    # セッションからユーザーを取得
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    # セッションがない場合、Cookieから取得
    elsif cookies.signed[:user_id] && cookies[:remember_token]
      user = User.find_by(id: cookies.signed[:user_id])
      # トークンが一致するか確認
      if user && user.remember_token == cookies[:remember_token]
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end
end
