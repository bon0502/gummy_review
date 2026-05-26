class OmniauthCallbacksController < ApplicationController
  skip_before_action :require_login, only: [:google_oauth2, :failure]

  def google_oauth2
    user_info = request.env['omniauth.auth']
    @user = User.find_or_create_from_google(user_info)

    if @user
      auto_login(@user)
      redirect_to root_path, notice: 'Googleアカウントでログインしました'
    else
      redirect_to login_path, alert: 'ログインに失敗しました'
    end
  end

  def failure
    redirect_to login_path, alert: 'ログインに失敗しました'
  end
end
