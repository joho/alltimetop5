class HomeController < ApplicationController
  def index
    @top_tags = List.tags_count(:limit => 5)
    
    @recent_lists = List.find(:all, 
                      :limit => 5, 
                      :order => 'lists.created_at DESC',
                      :include => [:user])
    
    @featured_list = List.find(:first,
                      :order => 'lists.created_at DESC',
                      :include => [:user, :list_items])
                      
    @user = session[:user]
  end
  
  def shoutouts
  end
end