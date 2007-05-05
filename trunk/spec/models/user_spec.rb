require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/hash_except_only'

module UserSpecHelper
  def valid_attributes
    { :username => 'jbarton', :email => 'jrbarton@gmail.com', 
      :password => 'password', :password_confirmation => 'password' }
  end
end

context "Creating a user" do
  include UserSpecHelper
  
  setup do
    @user = User.new
  end
  
  specify "Can't create a user without a username" do
    @user.attributes = valid_attributes.except :username
    @user.should_not be_valid
    @user.username = 'jbarton'
    @user.should be_valid
  end
  
  specify "Can't create a user without a password" do
    @user.attributes = valid_attributes.except :password
    @user.should_not be_valid
    @user.password = 'password'
    @user.should be_valid
  end
  
  specify "Can't create a user without confirming the password" do
    @user.attributes = valid_attributes.except :password_confirmation
    # This is a bit of a hack
    #@user.password_confirmation = ""
    @user.should_not be_valid
    @user.password_confirmation = @user.password
    @user.should be_valid
  end
  
  specify "Can't create a user without an email address" do
    @user.attributes = valid_attributes.except :email
    @user.should_not be_valid
    @user.email = 'jrbarton@gmail.com'
    @user.should be_valid
  end
end

