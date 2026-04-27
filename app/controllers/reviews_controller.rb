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

      @reviews = @q.result.includes(:user, :main_images)
                   .where('flavor LIKE ? OR flavor LIKE ?', "%#{katakana_keyword}%", "%#{hiragana_keyword}%")
                   .order(created_at: :desc).page(params[:page]).per(9)
    else
      @reviews = @q.result.includes(:user, :main_images).order(created_at: :desc).page(params[:page]).per(9)
    end
  end

  def show
    @review = Review.includes(:main_images).find(params[:id])
    @comment = Comment.new
    @comments = @review.comments.includes(:user, :main_images).order(created_at: :desc)
  end

  def new
    @review = Review.new
  end

  def edit
    @review = current_user.reviews.find(params[:id])
  end

  def create
    @review = current_user.reviews.build(review_params)

    if @review.save
      redirect_to review_path(@review), success: 'グミを投稿しました!'
    else
      Rails.logger.debug "Review errors: #{@review.errors.full_messages}"
      @review.main_images.each_with_index do |main_image, index|
        Rails.logger.debug "MainImage #{index} errors: #{main_image.errors.full_messages}"
      end

      flash.now[:danger] = 'グミの投稿に失敗しました…'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @review = current_user.reviews.find(params[:id])

    if @review.update(review_params)
      redirect_to review_path(@review), success: 'グミを更新しました!'
    else
      Rails.logger.debug "Review errors: #{@review.errors.full_messages}"
      @review.main_images.each_with_index do |main_image, index|
        Rails.logger.debug "MainImage #{index} errors: #{main_image.errors.full_messages}"
      end

      flash.now[:danger] = 'グミの更新に失敗しました…'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy
    redirect_to reviews_path, success: 'グミを削除しました!'
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
      :remove_photo_url,
      main_images_attributes: [:id, :image, :_destroy]
      # ⭐️ main_images_attributes は削除
      # main_images_images は許可しない（別途処理する）
    )
  end
end
