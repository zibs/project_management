class Api::V1::TasksController < Api::BaseController

  def create
    task_params = params.require(:task).permit(:title, :done, :body, :due_date, :project_id)
    task = Task.new(task_params)
    task.user = @user
    task.project = Project.find(params[:project_id])
    if task.save
      head :ok
    else
      render json: {errors: task.errors.full_messages}
    end
  end


end
