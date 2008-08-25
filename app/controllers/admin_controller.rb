class AdminController < ApplicationController
  before_filter :check_admin
  
  def index
  end
  
  def allusers
    @all_users = User.find(:all)
  end
  
  def alllists
    @all_lists = List.find(:all)
  end
  
  def viewlist
    @list = List.find(params[:id])
  end
  
  def system
  end
    
  private
    def check_admin
      authorize
      raise "Must be admin user" if session[:user].username != 'johnb'
    end
end
