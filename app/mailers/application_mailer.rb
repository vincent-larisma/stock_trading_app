class ApplicationMailer < ActionMailer::Base
  default from: 'scammer@stock_app.com'
  layout 'mailer'

  def approve_email(user)
    mail(:to => user.email, :subject => 'Your account has been approved. You can now buy and sell stocks')       
  end
end
