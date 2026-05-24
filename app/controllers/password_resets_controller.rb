class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      UserMailer.reset_password_email(@user).deliver_later
      redirect_to login_path, success: 'パスワードリセットのメールを送信しました。メールをご確認してください。'
    else
      flash.now[:danger] = 'メールアドレスが見つかりませんでした。'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)

    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: 'パスワードを変更しました。新しいパスワードでログインしてください。'
    else
      flash.now[:danger] = 'パスワードの変更に失敗しました。'
      render :edit, status: :unprocessable_entity
    end
  end
end
