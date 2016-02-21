class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update]
  before_action :authenticate_user


  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = Comment.new(comment_params)
    @comment.discussion = @discussion
    @comment.user = current_user
    if @comment.save
      DiscussionsMailer.notify_discussion_owner(@comment).deliver_later unless @discussion.user == current_user
      redirect_to discussion_path(@discussion), flash: { success:  "Comment created" }
    else
      render "discussions/show"
    end
  end

  def edit
  end

  def update
    @discussion = Comment.find(params[:id]).discussion_id
    if @comment.update(comment_params)
      redirect_to discussion_path(@discussion), flash: { success: "Comment updated..."}
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to discussion_path(params[:discussion_id]), flash: {danger: "Comment Deleted" }
  end

    private

      def find_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit([:body])
      end

end
