class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.order("created_at DESC")
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:alert] = "Project added"
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to project_path((@project), { notice: "project updated" })
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to root_path, alert: "project removed!"
  end

      private

        def project_params
          params.require(:project).permit([:title, :description, :due_date])
        end

        def find_project
          @project = Project.find(params[:id])
        end

end
