class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update]

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = Comment.new(comment_params)
    @comment.discussion = @discussion

    if @comment.save
      redirect_to discussion_path(@discussion), notice: "Comment created"
    else
      render "discussions/show"
    end
  end

  def edit
  end

  def update
    @discussion = Comment.find(params[:id]).discussion_id
    if @comment.update(comment_params)
      redirect_to discussion_path(@discussion), notice: "Comment updated..."
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to discussion_path(params[:discussion_id]), alert: "Comment Deleted"
  end

    private

      def find_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit([:body])
      end

end