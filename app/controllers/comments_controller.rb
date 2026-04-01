class CommentsController < ApplicationController
  before_action :require_login

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @review, success: "コメントを投稿しました"
    else
      redirect_to @review, danger: "コメント投稿に失敗しました"
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @review = @comment.review
    @comment.destroy
    redirect_to @review, success: "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
