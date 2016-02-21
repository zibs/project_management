class CollectNewTasksJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    recent_tasks = Task.where(["created_at >= ?", 1.day.ago])
    projects_with_new_tasks = Hash.new { |h, k| h[k] = [] }
    recent_tasks.each do |task|
      projects_with_new_tasks[task.project.user] << task
    end
    projects_with_new_tasks.each do |user, tasks|
      ProjectsMailer.summarize_new_tasks(user, tasks).deliver_later
    end
  end
end
