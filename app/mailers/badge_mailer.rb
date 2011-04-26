class BadgeMailer < ActionMailer::Base
  default :from => "badge@example.com"
  
  def send_badge(user, email, badge)
    @user = user
    attachments[badge.image.name] = File.read(badge.image.path)
    mail(:to => email,
         :subject => "You got a Badge!")
  end
end
