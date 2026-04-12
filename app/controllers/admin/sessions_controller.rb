class Admin::SessionsController < Admin::BaseController
  skip_before_action :require_admin_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]
  # layout 'admin_login'

  def new; end

  def create
    @admin_user = AdminUser.find_by(email: params[:email])

    if @admin_user && @admin_user.valid_password?(params[:password])
      session[:admin_user_id] = @admin_user.id
      redirect_to admin_root_path, success: t('admin.sessions.create.success')
    else
      flash.now[:danger] = t('admin.sessions.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:admin_user_id)
    redirect_to admin_login_path, success: t('admin.sessions.destroy.success'), status: :see_other
  end
end
