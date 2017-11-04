namespace :user_notice do
  task :notice_not_confirm => :environment do
    # UserEmailNotificationMailer.send_email_notify(@todayNews).deliver
    UserNotifierJobMailer.send_email_job_notify().deliver
  end  
end