class ApplicationMailer < ActionMailer::Base
  default from: 'scammer@stock_app.com'
  layout 'mailer'

  def approve_email(user)
    mail(:to => user.email, :subject => 'You successfully bought stocks!')       
  end
end
