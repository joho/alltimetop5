class UsersController < ApplicationController
  def index
    list
    render :action => 'login'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :create ],
         :redirect_to => { :action => :login }

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Hi #{@user.username}, thanks for registering."
      session[:user] = @user
      redirect_to_uri
    else
      render :action => 'new'
    end
  end
  
  def login
    @pagetitle = 'Alltimetop5 - Log in or create an account'
    # process the login request if a postback
    if request.post?
      @user = User.attempt_login(params[:user][:username], params[:user][:password])
      if @user
        flash[:notice] = "Welcome back #{@user.username}"
        session[:user] = @user
        redirect_to_uri
      else
        flash[:error] = "There was a problem logging you in. Please check your username and password"
        redirect_to :action => 'login'
      end
    else
      @user = session[:user]
    end
  end
  
  def logout
    unless session[:user].nil?
      flash[:notice] = "Goodbye #{session[:user].username}. You have been logged out."
      session[:user] = nil
    end
    
    redirect_to :action => 'login'
  end
  
  def forgot_password
    if request.post?
      @email_address = params[:email]
      user = User.find_by_email(@email_address)
      
      unless user
        flash[:error] = "Sorry we couldn't find a user with that email address"
        return
      end
      
      new_password = user.set_new_password
      
      begin
        UserMailer.deliver_forgot_password(user, new_password)
        flash[:notice] = "We have emailed you your login details."
        redirect_to :action => 'login'
      rescue
        flash[:error] = "There was a problem sending you your password. Please try again later."
      end
    end
  end
  
  private 
  def redirect_to_uri
    uri = session[:original_uri]
    session[:original_uri] = nil
    redirect_to(uri || {:controller => 'lists', :action => 'list'})
  end
end
