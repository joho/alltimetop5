class ListEmailer < ActionMailer::Base

  def share(list, email_addresses)
    subject    "The all time top 5 #{list.title} according to #{list.user.username}"
    body      :list => list
    recipients email_addresses
    from       'lists@alltimetop5.com'
    sent_on    Time.now
  end
  
  def responded(original_list, new_list)
    subject   "Your all time top 5 #{original_list.title} has been responded to by #{new_list.user.username}"
    body      :original_list => original_list, :new_list => new_list
    recipients  email_addresses
    from      'lists@alltimetop5.com'
    sent_on   Time.now
  end
end
