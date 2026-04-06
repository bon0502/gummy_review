# frozen_string_literal: true

class ReviewsController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    flavor_keyword = nil

    flavor_keyword = params[:q].delete(:flavor_cont) if params[:q] && params[:q][:flavor_cont].present?

    @q = Review.ransack(params[:q])

    if flavor_keyword.present?
      katakana_keyword = flavor_keyword.hiragana_to_katakana
      hiragana_keyword = flavor_keyword.katakana_to_hiragana

      @reviews = @q.result.includes(:user)
                   .where('flavor LIKE ? OR flavor LIKE ?', "%#{katakana_keyword}%", "%#{hiragana_keyword}%")
                   .order(created_at: :desc).page(params[:page]).per(9)
    else
      @reviews = @q.result.includes(:user).order(created_at: :desc).page(params[:page]).per(9)
    end
  end

  def show
    @review = Review.find(params[:id])
    @comment = Comment.new
    @comments = @review.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @review = Review.new
  end

  def edit
    @review = current_user.reviews.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id

    if @review.save

      # 複数画像の処理を追加
      save_main_images(@review)

      redirect_to review_path(@review), success: 'グミを投稿しました！'
    else
      flash.now[:danger] = 'グミの投稿に失敗しました…'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @review = current_user.reviews.find(params[:id])
    if @review.update(review_params)

      # 複数画像の処理を追加
      save_main_images(@review)

      redirect_to review_path(@review), success: 'グミを更新しました！'
    else
      flash.now[:danger] = 'グミの更新に失敗しました…'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy
    redirect_to reviews_path, success: 'グミを削除しました！'
  end

  private

  def review_params
    params.require(:review).permit(
      :gummy_name,
      :flavor,
      :rating,
      :sweetness,
      :sourness,
      :hardness,
      :comment,
      :photo_url,
      :purchase_location,
      :manufacturer_name,
      :gummy_name_kana,
      :flavor_kana,
      main_images_attributes: [:id, :image, :_destroy]
    )
  end

  # 複数画像を保存するメソッドを追加
  def save_main_images(review)
    # フォームから送られてきた複数画像を処理
    return unless params[:review][:main_images_images].present?

    params[:review][:main_images_images].each do |image|
      # 空のファイルは無視
      next if image.blank?

      review.main_images.create(image: image)
    end
  end
end
