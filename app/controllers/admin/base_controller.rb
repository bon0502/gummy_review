class Admin::BaseController < ApplicationController
  before_action :require_admin_login
  before_action :check_admin
  layout 'layouts/admin/application'

  private

  def require_admin_login
    unless current_admin_user
      redirect_to admin_login_path, alert: t('defaults.flash_message.require_login')
    end
  end

  # Sorcery のセッション管理を AdminUser 用に設定
  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
  end
  helper_method :current_admin_user

  def check_admin
    redirect_to root_path, alert: t('defaults.flash_message.not_authorized') unless current_admin_user
  end

  def not_authenticated
    redirect_to admin_login_path, alert: t('defaults.flash_message.require_login')
  end
end
