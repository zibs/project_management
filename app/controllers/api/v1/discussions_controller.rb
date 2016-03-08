class Api::V1::DiscussionsController < Api::BaseController

  def show
    @discussion = Discussion.find(params[:id])
    render json: @discussion
  end

end
