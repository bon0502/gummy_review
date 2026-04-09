class Admin::SessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]
  layout 'admin_login'

  def new; end

  def create
    @admin_user = login(params[:email], params[:password])

    if @admin_user
      redirect_to admin_root_path, success: t('.success')
    else
      logout
      flash.now[:danger] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, success: t('.success')
  end
end
