class Admin::UsersController < Admin::BaseController
  layout 'admin/application'
  before_action :set_user, only: [:edit, :update, :destroy, :show, :reset_password]

  def index
    @users = User.all.order(created_at: :desc).page(params[:page])
  end

  def show
    # @user は before_action で設定済み
    @reviews = @user.reviews.page(params[:page]).per(20)
  end

  def edit
    # @user は before_action で設定済み
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, success: 'ユーザー情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, success: 'ユーザーを削除しました'
  end

  def reset_password
    # ランダムなパスワードを生成
    new_password = SecureRandom.alphanumeric(12)

    if @user.update(password: new_password, password_confirmation: new_password)
      # 新しいパスワードをフラッシュメッセージで表示
      redirect_to admin_users_path,
                  success: "パスワードをリセットしました。新しいパスワード: #{new_password}"
    else
      redirect_to admin_users_path, danger: 'パスワードのリセットに失敗しました'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
  end
end
