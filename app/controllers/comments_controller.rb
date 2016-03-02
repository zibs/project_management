class CommentsController < ApplicationController
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user


  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = Comment.new(comment_params)
    @comment.discussion = @discussion
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        DiscussionsMailer.notify_discussion_owner(@comment).deliver_later unless @discussion.user == current_user
        format.html { redirect_to discussion_path(@discussion), flash: { success:  "Comment created" } }
        format.js { render :comment_create_success }
      else

        format.html { render "discussions/show" }
        format.js { render :comment_create_failure}
      end
    end
  end

  def edit
    @discussion = @comment.discussion
    respond_to do |format|
      format.js { render :edit_comment}
    end
  end

  def update
    # @discussion = Comment.find(params[:id])
    @discussion = @comment.discussion
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to discussion_path(@discussion), flash: { success: "Comment updated..."}}
        format.js { render :update_comment_success }
      else
        format.js { render :update_comment_failure }
      end
    end
  end

  def destroy
    @discussion = @comment.discussion
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to discussion_path(params[:discussion_id]), flash: {danger: "Comment Deleted" } }
      format.js { render }
    end
  end

    private

      def find_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit([:body])
      end

end
