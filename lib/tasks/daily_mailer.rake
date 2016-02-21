namespace :daily_mailer do

  desc "Send New Daily Tasks to Project Owners"
  task :new_tasks => :environment do
    CollectNewTasksJob.perform_later
  end
  
end
