class NotificationsMailer < ActionMailer::Base

  default :from => "noreply@webdevlasse.mygbiz.com"
  default :to => "webdevlasse@webdevlasse.mygbiz.com"

  def new_message(message)
    @message = message
    mail(:subject => "[Chai.tld] #{message.subject}")
  end

end
