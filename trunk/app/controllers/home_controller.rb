class HomeController < ApplicationController
  def index
    
    @top_tags = List.tags_count(:limit => 5)
    
    #@top_tags = "bands, games, films, football, TV shows"
    
    @recent_lists = List.find(:all, :limit => 5, :order => 'created_at DESC')
    
    @featured_list = List.find(:first, :order => 'created_at DESC')
  end
end
