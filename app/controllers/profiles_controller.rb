# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show; end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if current_user.update(profile_params)
      redirect_to profile_path, success: t('.success')
    else
      flash.now[:danger] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:email, :nickname, :avatar)
  end
end
