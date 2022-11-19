class ApplicationMailer < ActionMailer::Base
  default from: 'scammer@stock_app.com'
  layout 'mailer'

  def approve_email(user, stock)
    mail(:to => user.email, :subject => "You, my love, successfully bought #{stock.shares} stocks of #{stock.symbol}!")       
  end
end
