namespace :daily_mailer do

  desc "Send New Daily Tasks to Project Owners"
  task :new_tasks => :environment do
    CollectNewTasksJob.perform_later
  end

  desc "Send New Discussions to Project Owners"
  task :new_discussion => :environment do
    CollectNewDiscussionsJob.perform_later
  end


end
