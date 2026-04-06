class Admin::ReviewsController < Admin::BaseController
  before_action :set_review, only: [:destroy, :show]

  def index
    @reviews = Review.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    # @review は before_action で設定済み
  end

  def destroy
    @review.destroy!
    redirect_to admin_reviews_path, success: 'レビューを削除しました'
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end
end
