class UserMailer < ActionMailer::Base

  def welcome(sent_at = Time.now)
    @subject    = 'UserMailer#welcome'
    @body       = {}
    @recipients = ''
    @from       = ''
    @sent_on    = sent_at
    @headers    = {}
  end

  def forgot_password(user, new_password)
    subject    "Password reset for alltimetop5.com"
    body      :user => user, :new_password => new_password
    recipients user.email
    from       'users@alltimetop5.com'
    sent_on    Time.now
  end
end
