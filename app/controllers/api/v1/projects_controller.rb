class Api::V1::ProjectsController < Api::BaseController

  def index
    @projects = Project.order("created_at DESC").limit(1)
    render json: @projects
  end

  def show
    @project = Project.find(params[:id])
    render json: @project
  end


def create
  project_params = params.require(:project).permit(:title, :description, :due_date)
  project = Project.new(project_params)
  project.user = @user
  if project.save
    head :ok
  else
    render json: { errors: project.errors.full_messages }
  end
end


end
