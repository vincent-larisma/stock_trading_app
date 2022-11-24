class ApplicationMailer < ActionMailer::Base
  default from: 'scammer@stock_app.com'
  layout 'mailer'

  def buy_stocks(user, stock, stocks_bought)
    mail(:to => user.email, :subject => "You successfully bought #{stocks_bought} stocks of #{stock.symbol}!")       
  end

  def approve_trader_email(user)
    mail(:to => user.email, :subject => "Your account has been approved. Re-login your account so you can start buying and selling stocks!")
  end
end
