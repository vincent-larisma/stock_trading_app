require "test_helper"

class ApproveEmailMailerTest < ActionMailer::TestCase
  test "approve_email" do
    mail = ApproveEmailMailer.approve_email
    assert_equal "Approve email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
