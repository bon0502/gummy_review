# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      # ログイン成功時の処理

      # 「ログイン状態を保持する」にチェックが入っている場合
      if params[:remember_me] == '1'
        # ランダムなトークンを生成してDBに保存
        remember_token = SecureRandom.urlsafe_base64
        @user.update(remember_token: remember_token)

        # 有効期限を2週間に設定した永続的なCookieを作成
        cookies.signed[:user_id] = {
          value: @user.id,
          expires: 2.weeks.from_now,
          httponly: true
        }
        cookies[:remember_token] = {
          value: remember_token,
          expires: 2.weeks.from_now,
          httponly: true
        }
      end

      redirect_to root_path, success: t('.success')
    else
      # ログイン失敗時の処理
      flash.now[:danger] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t('.success')
  end
end
