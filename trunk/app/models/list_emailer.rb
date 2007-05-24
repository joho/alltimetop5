class ListEmailer < ActionMailer::Base

  def share(list, email_addresses)
    subject    "The all time top 5 #{list.title} according to #{list.user.username}."
    body      :list => list
    recipients email_addresses
    from       'lists@alltimetop5.com'
    sent_on    Time.now
  end
end
