class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
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
