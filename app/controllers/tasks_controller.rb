class TasksController < ApplicationController
    before_action :find_task, only: [:show, :edit, :update, :destroy]

    def index
      @tasks = Task.order("created_at DESC")
    end

    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_params)
      if @task.save
        flash[:alert] = "task added"
        redirect_to task_path(@task)
      else
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
      if @task.update(task_params)
        redirect_to task_path((@task), { notice: "task updated" })
      else
        render :edit
      end
    end

    def destroy
      @task.destroy
      redirect_to root_path, alert: "task removed!"
    end

          private

          def task_params
            params.require(:task).permit([:title])
          end

          def find_task
            @task = Task.find(params[:id])
          end

end