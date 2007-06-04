class ListsController < ApplicationController
  #user must be logged in to use this controller
  before_filter :authorize
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update, :email ],
         :redirect_to => { :action => :list }

  def list
    @pagetitle = 'My Alltimetop5'
    # TODO: replace with err.the_blog's pagination functionality
    user = session[:user]
    @lists = user.lists.find(:all, :order => 'lists.created_at DESC')
  end

  def show
    @list = List.find(params[:id], :include => [:list_items, :user])
    redirect_to(:controller => 'browse',
                :username => @list.user.username,
                :action => 'visitlist',
                :id => @list) if session[:user].id != @list.user.id
  end

  def old_new
    @pagetitle = 'Alltimetop5 - Create a new top 5 list'
    @list = List.new
    rebuttal_id = params[:id]
    if rebuttal_id
      @rebuttal_mode = true
      rebutted_list = List.find(rebuttal_id)
      @create_title = "Respond to #{rebutted_list.user.username}'s all time top 5 #{rebutted_list.title}"
      @list.rebuts = rebutted_list
    end
  end

  def old_create
    if request.xhr?
      # handle the ajax request to create
      @list = List.new(params[:list])
      if @list.save
        # render the js to update stuff properly
      else
        # render something with the error message
      end
    else
      # revert to the old form's behaivour
      params[:list][:comment] = nil if params[:list][:comment].empty?
      @list = List.new(params[:list])
      @list.user = session[:user]
    
      # dynamically load up all 5 of the list items
      for position in 1..5
        list_item_hash = params["list_item#{position}"]
        list_item = ListItem.new
        list_item.title = list_item_hash[:title]
        list_item.comment = list_item_hash[:comment]
        list_item.rank = position
        @list.list_items << list_item
      end
    
      if @list.save
        flash[:notice] = "We've saved your all time top 5 #{@list.title}"
        @list.tag(params[:tag_list].sub(',', ''))
        redirect_to :action => 'list'
      else
        ApplicationHelper.tidy_error_messages(@list, ['list_items'])
        render :action => 'new'
      end
    end
  end
  
  def share
    @list = List.find(params[:id])
    @pagetitle = "Alltimetop5 - Share your all time top 5 #{@list.title} with the world"
  end
  
  def email
    if request.post?
      begin
        @list = List.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:error] = "Sorry, we can't find that list"
      end
      # send out the email
      
      email_addresses = Array.new
      for i in 1..5
        email = params["email_address_#{i}"]
        email_addresses << email unless (email.nil? || email.empty?)
      end
      
      unless email_addresses.empty?
        begin
          email_addresses.each { |e| ListEmailer.deliver_share(@list, e) }
          flash[:notice] = 'Your emails have been sent out. Feel free to send more!'
        rescue Exception => boom
          flash[:error] = 'Sorry, there was a hiccup trying to send mail, maybe try again later'
          flash[:debug_info] = boom
        end
      else
        flash[:error] = 'You must include at least one email adress!'
      end
    else
      flash[:error] = "Sorry, we couldn't complete your request. Please try again"
    end
    redirect_to :action => 'share', :id => params[:id]
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(params[:list])
      flash[:notice] = 'List was successfully updated.'
      redirect_to :action => 'show', :id => @list
    else
      ApplicationHelper.tidy_error_messages(@list, ['list_items'])
      render :action => 'edit'
    end
  end

  def destroy
    list = List.find(params[:id])
    flash[:notice] = "Deleted your all time top 5 #{list.title}"
    list.destroy
    redirect_to :action => 'list'
  end
  
  def tag
    @list = List.find(params[:id])
    @pagetitle = "Alltimetop5 - Tag your all time top 5 #{@list.title} to make it easier to find"
    if request.post?
      @list.tag(params[:tag_list].sub(',', ''))
      flash[:notice] = "Successfully tagged all time top 5 #{@list.title}"
      redirect_to :action => 'list'
    end
  end
  
  def edit
    @user = session[:user] unless session[:user].nil?
    @list = List.find(params[:id], :include => [:list_items, :user])
    @pagetitle = "Alltimetop5 - Editing your top 5 #{@list.title}"
    
    if @user.id != @list.user.id
      flash[:error] = "Sorry, you can't edit that list"
      redirect_to :controller => 'lists'
      return
    end
    
    @new_list_item = nil
    if @list.list_items.size < 5
      @new_list_item = ListItem.new
      @new_list_item.rank = @list.list_items.size
      @new_list_item.list_id = @list.id
    end
  end
  
  def ajax_edit
    @list = List.find(params[:id])
    
    if request.post?
      if @list.update_attributes(params[:list])
        redirect_to :controller => 'lists', :action => 'ajax_view', :id => @list
        return
      end
    end
    render :layout => false
  end
  
  def ajax_view
    @list = List.find(params[:id])
    render :layout => false
  end
  
  def new
    @pagetitle = 'Alltimetop5 - Write a list'
    @list = List.new(:published => false)
  end
  
  def create
    @list = List.new(params[:list])
    @list.published = false
    @list.user = session[:user]
    @all_ok = @list.save
    
    render :layout => false;
  end
end
