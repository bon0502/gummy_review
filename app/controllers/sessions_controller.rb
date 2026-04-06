# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id

      # チェックボックスがONの場合、永続的なCookieを設定
      if params[:remember_me] == '1'
        # ランダムなトークンを生成してDBに保存
        remember_token = SecureRandom.urlsafe_base64
        user.update(remember_token: remember_token)

        # 永続的なCookieを設定（2週間有効）
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = remember_token
      end

      redirect_to users_path, notice: 'ログインしました'
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    redirect_to root_path
  end
end
