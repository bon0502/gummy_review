class Admin::BaseController < ApplicationController
  layout 'admin/application'
  before_action :require_login
  before_action :check_admin

  private

  def not_authenticated
    redirect_to login_path, alert: 'ログインしてください'
  end


  def check_admin
    redirect_to root_path, alert: '管理者権限が必要です' unless current_user.admin?
  end
end
