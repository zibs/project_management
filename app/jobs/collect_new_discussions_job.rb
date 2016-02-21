class CollectNewDiscussionsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    recent_discussions = Discussion.where(["created_at >= ?", 1.day.ago])
    projects_with_new_discussions = Hash.new { |h, k| h[k] = [] }
    recent_discussions.each do |discussion|
      projects_with_new_discussions[discussion.project.user] << discussion
    end
    projects_with_new_discussions.each do |user, project|
    ProjectsMailer.summarize_new_discussions(user, project).deliver_later
    end
  end
end
