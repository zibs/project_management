class DiscussionsController < ApplicationController
  before_action :find_discussion, only: [:show, :update, :edit, :destroy]

  def create
    @project = Project.find(params[:project_id])
    @discussion = Discussion.new(discussion_params)
    @discussion.project = @project

    if @discussion.save
      redirect_to discussion_path(@discussion), notice: "Discussion Initialized"
      # render json: params
    else
      render "projects/show"
    end
  end

  def show
    @comment = Comment.new
    @comments = @discussion.comments
  end

  def edit
  end

  def update
    if @discussion.update(discussion_params)
      redirect_to discussion_path(@discussion), notice: "Discussion updated..."
    end
    # render json: params
  end

  def destroy
    discussion = Discussion.find(params[:id])
    discussion.destroy
    redirect_to project_path(params[:project_id]), alert: "Discussion Removed..."
  end


    private

      def find_discussion
        @discussion = Discussion.find(params[:id])
      end

      def discussion_params
        params.require(:discussion).permit([:title, :body])
      end
end
