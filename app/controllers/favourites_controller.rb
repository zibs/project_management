class FavouritesController < ApplicationController
  before_action :authenticate_user

  def index
    @favourites = current_user.favourite_projects.order("created_at DESC")
  end

  def create
    project = Project.find(params[:project_id])
    favourite = Favourite.new(project: project, user: current_user)
    if favourite.save
      redirect_to project, flash: { success: "<3"}
    else
      redirect_to project, flash: { info: "already <3ed"}
    end
  end

  def destroy
    favourite = current_user.favourites.find(params[:id])
    favourite.destroy
    redirect_to project_path(params[:project_id]), flash: {warning: "un<3ed"}
  end

end
