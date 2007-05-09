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
    # TODO: replace with err.the_blog's pagination functionality
    
    user = session[:user]
    if user.nil?
      flash[:error] = 'You must be logged in to manage your lists'
      redirect_to :controller => 'users', :action => 'login'
    end
    
    @lists = user.lists
  end

  def show
    @list = List.find(params[:id], :include => [:list_items])
  end

  def new
    @list = List.new
  end

  def create
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
      flash[:notice] = 'List was successfully created.'
      redirect_to :action => 'list'
    else
      ApplicationHelper.tidy_error_messages(@list, ['list_items'])
      render :action => 'new'
    end
  end
  
  def share
    @list = List.find(params[:id])
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
        email_addresses << email unless email.nil?
      end
      
      unless email_addresses.empty?
        ListsEmailer.deliver_share(@list, email_addresses)
        flash[:notice] = 'Your emails have been sent out. Feel free to send more!'
      else
        flash[:error] = 'You must include at least one email adress!'
      end
    else
      flash[:error] = "Sorry, we couldn't complete your request. Please try again"
    end
    redirect_to :action => 'share', :id => params[:id]
  end

  def edit
    @user = session[:user] unless session[:user].nil?
    @list = List.find(params[:id])
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
    List.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def tag
    @list = List.find(params[:id])
    if request.post?
      @list.tag(params[:tag_list])
      flash[:notice] = "Successfully tagged all time top 5 #{@list.title}"
      redirect_to :action => 'list'
    end
  end
end
