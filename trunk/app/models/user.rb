require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :lists
  
  attr_accessor :password, :password_confirmation
  attr_accessible :username, :email, :password, :password_confirmation

  validates_uniqueness_of :username
  validates_confirmation_of :password
  validates_presence_of :username, :email, :password
  
  def before_create
    self.hashed_password = User.hash_password(self.password)
  end
  
  def after_create
    @password = nil
  end
  
  #def validate
  #  errors.add('password_confirmation', 'need to match passwords') unless password == password_confirmation
  #end
  
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
end
