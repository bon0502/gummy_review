class ReviewsController < ApplicationController

  skip_before_action :require_login, only: %i[index]

  def index
    @reviews = Review.all
    @reviews = Review.order(created_at: :desc).page(params[:page]).per(9)
  end

  def new
    @review = Review.new
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to review_path(@review), success: "グミを投稿しました！"
    else
      flash.now[:danger] = "グミの投稿に失敗しました…"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:photo_url, :gummy_name, :rating, :flavor, :hardness, :sweetness, :sourness, :manufacturer_name, :comment, main_images: [])
  end
end
