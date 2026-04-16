class Admin::SessionsController < Admin::BaseController
  skip_before_action :require_admin_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]
  layout 'layouts/admin/application'

  def new; end

  def create
    # Sorcery の login メソッドを使って認証
    @admin_user = AdminUser.authenticate(params[:email], params[:password])

    if @admin_user
      # ログイン成功
      session[:admin_user_id] = @admin_user.id
      redirect_to admin_root_path, notice: t('admin.sessions.create.success')
    else
      # ログイン失敗
      flash.now[:alert] = t('admin.sessions.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:admin_user_id] = nil
    redirect_to admin_login_path, notice: t('admin.sessions.destroy.success')
  end
end
