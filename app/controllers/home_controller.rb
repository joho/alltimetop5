class HomeController < ApplicationController
  def index
    @top_tags = List.tags_count(:limit => 5) # TODO: sort this
    
    @recent_lists = List.top5_recently_created
    
    @featured_list = List.featured_list
                      
    @featured_list_url = url_for({:controller => 'browse',
                			:username => @featured_list.user.username,
                			:action => 'visitlist',
                			:id => @featured_list})
                      
    @user = session[:user]
  end
  
  def shoutouts
  end
end