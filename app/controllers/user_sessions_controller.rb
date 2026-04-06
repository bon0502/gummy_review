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
        remember_me!  # ← Sorcery のメソッドを使用
      else
        forget_me!    # ← チェックが入っていない場合は削除
      end

      redirect_to root_path, success: t('.success')
    else
      # ログイン失敗時の処理
      flash.now[:danger] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # 永続的なセッション（remember token）を削除
    # ※ logout より前に実行する必要がある
    forget_me! if logged_in?

    # 通常のセッションをログアウト
    logout

    # セッション全体をリセット
    reset_session

    flash[:success] = t('user_sessions.destroy.success')
    redirect_to root_path, status: :see_other
  end
end
