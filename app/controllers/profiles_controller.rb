class ProfilesController < ApplicationController
  def show; end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if current_user.update(profile_params)
      redirect_to profile_path, success: t('profiles.update.success')
    else
      flash.now[:danger] = t('profiles.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:email, :nickname, :avatar)
  end
end
