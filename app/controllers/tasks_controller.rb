class TasksController < ApplicationController
    before_action :find_task, only: [:show, :edit, :update, :destroy]

    # def index
    #   @tasks = Task.order("created_at DESC")
    # end
    #
    # def new
    #   @task = Task.new
    # end

    def create
      @project = Project.find(params[:project_id])
      @task = Task.new(task_params)
      @task.project = @project
      if @task.save
        redirect_to project_path(@project), notice: "Task Added"
      else
        render "projects/show"
      end
      # @task = Task.new(task_params)
      # if @task.save
      #   flash[:alert] = "task added"
      #   redirect_to task_path(@task)
      # else
      #   render :new

    end
    #
    # def show
    # end
    #
    # def edit
    # end
    #
    def update
      @task.update(task_params)
      redirect_to project_path(params[:project_id]), notice: "Project Changed!"

    #   if @task.update(task_params)
    #     redirect_to task_path((@task), { notice: "task updated" })
    #   else
    #     render :edit
    #   end
    end

    def destroy
        task = Task.find(params[:id])
        task.destroy
        redirect_to project_path(params[:project_id]), alert: "task removed!"
    end

          private

          def task_params
            params.require(:task).permit([:title, :due_date, :done])
          end

          def find_task
            @task = Task.find(params[:id])
          end

end
