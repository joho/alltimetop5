class BrowseController < ApplicationController
  def index
    @pagetitle = 'Browsing Alltimetop5'
    @tags_count = List.tags_count(:limit => 50)
    
    @top_users = User.top5_by_total_list_views
    
    @top_lists = List.top5_by_fullviews
  end
  
  def lists
    @pagetitle = 'Alltimetop5 - Going through all the lists'
    #TODO: This action is for just browsing through lists (add categories maybe?)
    @lists = List.find(:all, :include => [:user], :order => 'lists.created_at DESC')
  end

  def finduser
    if request.post?
      # TODO: pattern match for email to save extra db hit
      user = User.find(:first,
        :conditions => ['email = ?', params[:searchterm]])
        
      user ||= User.find(:first,
        :conditions => ['username = ?', params[:searchterm]])
      if user
        # redirect to user lists browse
        redirect_to :action => "visitlists", :username => user.username
        #flash[:notice] = user.inspect
      else
        flash[:notice] = "Couldn't find a user to match #{params[:searchterm]}"
      end
    end
  end
  
  def visitlists
    # display a set of lists for a particular user
    @user = User.find_by_username(params[:username])
    @pagetitle = "Alltimetop5 - Showing all lists for #{@user.username}"
  end
  
  def visitlist
    @current_user = session[:user]
    
    @user = User.find_by_username(params[:username])
    
    @list = List.find(params[:id], :include => [:list_items])

    @pagetitle = "Alltimetop5 - #{@user.username}'s all time top 5 #{@list.title}"
    
    @rebuttals =  @list.rebuttals.find(:all, :include => [:user])
    
    @list.log_fullview
  end
  
  def show_tag
    # show some tagging love
    @tag_name = params[:tag_name]
    @pagetitle = "Alltimetop5 - Viewing all lists tagged with #{@tag_name}"
    # TODO: Replace this tagged with call - it gives a n + 1 db call issue
    @lists = List.find_tagged_with(:all => @tag_name)
  end
end
