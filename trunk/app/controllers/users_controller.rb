class UsersController < ApplicationController
  # must be logged in in all cases, except when logging in
  before_filter :authorize, :except => [:login, :new, :create]
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    # TODO: replace with err.the_blog's i_will_paginate functionality
    @user_pages, @users = paginate :users, :per_page => 10
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Hi #{@user.username}, thanks for registering."
      session[:user] = @user
      redirect_to :controller => 'lists'
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def login
    # process the login request if a postback
    if request.post?
      @user = User.attempt_login(params[:user][:username], params[:user][:password])
      if @user
        flash[:notice] = "Welcome back #{@user.username}"
        session[:user] = @user
        redirect_to :controller => 'lists', :action => 'list'
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
end
