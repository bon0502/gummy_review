# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login, unless: :admin_controller?

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def not_authenticated
    redirect_to login_path, warning: t('defaults.message.require_login')
  end

  # 管理者コントローラかどうかを判定
  def admin_controller?
    self.class.name.start_with?('Admin::')
  end
end
