class ListEmailer < ActionMailer::Base

  def share(list, email_addresses)
    @subject    = "#{list.user.username} wants to share their alltimetop5 #{list.title} with you"
    @body       = { :list => list }
    @recipients = email_addresses
    @from       = 'lists@alltimetop5.com'
    @sent_on    = Time.now
    @headers    = {}
  end
end
