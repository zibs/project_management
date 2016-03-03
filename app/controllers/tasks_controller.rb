class TasksController < ApplicationController
    before_action :find_task, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user

    # def index
    #   @tasks = Task.order("created_at DESC")
    # end
    # def new
    #   @task = Task.new
    # end

    def create
      @project = Project.find(params[:project_id])
      @task = Task.new(task_params)
      @task.project = @project
      @task.user = current_user
      respond_to do |format|
        if @task.save
          format.html { redirect_to project_path(@project), flash: { sucess: "Task Added" } }
          format.js { render :successful_task }
        else
          format.html { render "projects/show" }
          format.js { render :unsuccessful_task }
        end
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
    def edit
      respond_to do |format|
        format.js { render :edit_task_form }
      end
    end
    #
    def update
      @project = @task.project
      respond_to do |format|
        if @task.update(task_params)
          if task_params[:title].present?
            format.js { render :edit_task_success}
          else
            format.html { redirect_to project_path(params[:project_id]), flash: { success: "Task Changed" } }
            format.js { render :successfully_update_task }
          end
          if @task.user != current_user && @task.done?
          TasksMailer.notify_task_owner(@task, current_user).deliver_later
          end
        else
          format.js { render :edit_task_unsuccessful}
        end
      end
    end

    #   if @task.update(task_params)
    #     redirect_to task_path((@task), { notice: "task updated" })
    #   else
    #     render :edit
    #   end

    def destroy
      task = Task.find(params[:id])
      @project = task.project
      task.destroy
      respond_to do |format|
        format.html { redirect_to project_path(params[:project_id]), flash: { danger:  "task removed!" } }
        format.js { render }
      end
    end

    def sort
      params[:task].each_with_index do |id, index|
        Task.find(id).update!(position: index + 1)
      end
      head :ok
    end

          private

          def task_params
            params.require(:task).permit([:title, :due_date, :done])
          end

          def find_task
            @task = Task.find(params[:id])
          end

end
