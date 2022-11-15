# Preview all emails at http://localhost:3000/rails/mailers/approve_email_mailer
class ApproveEmailMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/approve_email_mailer/approve_email
  def approve_email
    ApproveEmailMailer.approve_email
  end

end
