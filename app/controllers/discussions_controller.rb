class DiscussionsController < ApplicationController
  before_action :find_discussion, only: [:show, :update, :edit, :destroy]
  before_action :authenticate_user, except: [:show, :index]

  def create
    @project = Project.find(params[:project_id])
    @discussion = Discussion.new(discussion_params)
    @discussion.project = @project
    @discussion.user = current_user
    if @discussion.save
      redirect_to discussion_path(@discussion), flash: {success:  "Discussion Initialized"}
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
      redirect_to discussion_path(@discussion), flash: {success:  "Discussion Updated"}
    end
    # render json: params
  end

  def destroy
    discussion = Discussion.find(params[:id])
    discussion.destroy
    redirect_to project_path(params[:project_id]), flash: {danger: "Discussion Removed..."}
  end


    private

      def find_discussion
        @discussion = Discussion.find(params[:id])
      end

      def discussion_params
        params.require(:discussion).permit([:title, :body])
      end
end
