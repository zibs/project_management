class TasksMailer < ApplicationMailer
  def notify_task_owner(task, task_completer)
    @task = task
    @owner = @task.user
    @task_completer = task_completer

    mail(to: @owner.email, subject: "Task Complete")

  end
end
