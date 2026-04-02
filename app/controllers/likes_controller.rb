class LikesController < ApplicationController
  before_action :require_login
  before_action :set_review

  def create
    current_user.likes.create(review: @review)
    redirect_to @review, success: "いいねしました!"
  end

  def destroy
    current_user.likes.find_by(review: @review).destroy
    redirect_to @review, success: "いいねを解除しました"
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end
end
