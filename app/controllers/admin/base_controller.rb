class Admin::BaseController < ApplicationController
  before_action :require_admin_login
  before_action :check_admin

  layout 'admin/application'

  private

  # 管理者用の current_user メソッド（ApplicationController の current_user を上書き）
  def current_user
    current_admin_user
  end

  # 管理者用の current_admin_user メソッド
  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
  end
  helper_method :current_admin_user

  # 管理者用のログインチェック
  def require_admin_login
    unless logged_in?
      redirect_to admin_login_path, alert: t('defaults.flash_message.require_login')
    end
  end

    # 管理者権限のチェック（追加）
  def check_admin
    unless current_admin_user&.admin?
      redirect_to root_path, alert: t('defaults.flash_message.not_authorized')
    end
  end

  def not_authenticated
    redirect_to admin_login_path, alert: t('defaults.flash_message.require_login')
  end

  # ログイン状態のチェック（追加）
  def logged_in?
    current_admin_user.present?
  end
end
