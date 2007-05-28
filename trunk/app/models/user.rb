require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :lists
  
  attr_accessor :password, :password_confirmation
  attr_accessible :username, :email, :password, :password_confirmation

  validates_uniqueness_of :username
  validates_confirmation_of :password
  validates_presence_of :username, :email, :password
  #validates_format_of :username, :with => /[a-zA-Z0-9_]{3,25}/, :message => 'Sorry, your username must be alphanumeric and at least 3 characters long'
  
  def before_create
    self.hashed_password = User.hash_password(self.password)
  end
  
  def after_create
    @password = nil
  end
  
  def validate
    errors.add('username', "Sorry, that username isn't allowed") if disallowed_usernames.include? username
  end
  
  def self.hash_password(password)
    Digest::SHA1.hexdigest(password)
  end
  
  def self.attempt_login(username, password)
    hashed_password = User.hash_password(password)
    
    User.find(
      :first, 
      :conditions => ["username = ? and hashed_password = ?", username, hashed_password])
  end
  
  def self.find_by_username(username)
    User.find(
      :first,
      :conditions => ['username = ?', username],
      :order      => "users.updated_at DESC",
      :include    => [:lists] )
  end
  
  def self.top5_by_total_list_views
    User.find_by_sql('select users.* from users inner join lists on users.id = lists.user_id
    group by lists.user_id order by sum(lists.fullviews) desc limit 5')
  end
  
  def disallowed_usernames
    %w(root admin alltimetop5 adminstrator)
  end
end