class ProjectsMailer < ApplicationMailer

  def summarize_new_tasks(user, tasks)
    @project_owner = user
    @tasks = tasks
    @project = tasks[0].project
    mail(to: @project_owner.email, subject: "Today's New Tasks")
  end

end
