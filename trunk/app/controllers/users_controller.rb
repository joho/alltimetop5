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
    # process the login request if a postback
    if request.post?
      @user = User.attempt_login(params[:user][:username], params[:user][:password])
      if @user
        flash[:notice] = "Welcome back #{@user.username}"
        session[:user] = @user
        redirect_to_uri
      else
        flash[:notice] = "There was a problem logging you in. Please check your username and password"
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
  
  private 
  def redirect_to_uri
    uri = session[:original_uri]
    session[:original_uri] = nil
    redirect_to(uri || {:controller => 'lists', :action => 'list'})
  end
end
