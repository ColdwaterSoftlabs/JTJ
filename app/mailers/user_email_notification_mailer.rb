class UserEmailNotificationMailer < ApplicationMailer

	default from: "mcpuram@gmail.com"

	def send_email_notify(todayNews)
		@todayMessage=todayNews
   	    to = "rajeshmca2k10@gmail.com"
	    cc = "rajesh.muniappan@kaaylabs.com"
	    subject = "Today Message"
	    mail(to: to, cc: cc, subject: subject)
  	end
end
