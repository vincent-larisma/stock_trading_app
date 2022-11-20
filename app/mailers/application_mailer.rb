class ApplicationMailer < ActionMailer::Base
  default from: 'scammer@stock_app.com'
  layout 'mailer'

  def approve_email(user, stock)
    mail(:to => user.email, :subject => "You successfully bought #{stock.shares} stocks of #{stock.symbol}!")       
  end

  def approve_trader_email(user)
    mail(:to => user.email, :subject => "Your account has been approved")
  end
end
