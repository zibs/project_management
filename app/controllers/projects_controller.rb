class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @projects = Project.order("created_at DESC").page(params[:page]).per(7)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      flash[:success] = "Project added"
      redirect_to project_path(@project)
    else
      flash[:warning] = "Project unsuccessfully added"
      render :new
    end
  end

  def show
    @task = Task.new
    @discussion = Discussion.new
    # @tasks = @project.tasks.order("created_at DESC")
    # display complete/incomplete tasks
    @tasks = @project.tasks.order(:position)
    # @tasks_done = @project.tasks.where(["done = ?", true]).order("created_at DESC")
    # @tasks_not_done = @project.tasks.where(["done = ?", false]).order("created_at DESC")
    @discussions = @project.discussions.order("created_at DESC")
  end

  def edit
  end

  def update
    @project.slug = nil
    if @project.update(project_params)
      redirect_to(project_path(@project), flash: { success:  "Project Updated"})
    else
      flash[:warning] = "Update was not successful"
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to((root_path), flash: { danger: "Project Removed!" })
  end


      private

        def project_params
          params.require(:project).permit([:title, :description, :due_date, {images: [] }])
        end

        def find_project
          @project = Project.friendly.find(params[:id])
        end

        def authorize_user
          unless can? :manage, @project
          redirect_to root_path , flash: { info: "Access Denied" }
          end
        end

end
