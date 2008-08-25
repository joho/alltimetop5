class ListItemsController < ApplicationController
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :move_up, :move_down, :create ],
         :redirect_to => { :controller => :lists }

  def destroy
    list_item = ListItem.find(params[:id], :include => [:list])
    @list = list_item.list
    if @list.published = 1
      @list.published = 0
      @list.save
    end
    
    list_item.destroy
    render :layout => false
  end
  
  def move_up
    list_item = ListItem.find(params[:id])
    list_item.move_higher unless list_item.first?
    @moved_up = list_item
    @moved_down = list_item.lower_item
    render :layout => false
  end
  
  def move_down
    list_item = ListItem.find(params[:id])
    list_item.move_lower unless list_item.last?
    @moved_down = list_item
    @moved_up = list_item.higher_item
    render :layout => false
  end
  
  def create
    @list = List.find(params[:id])
    @list_item = @list.list_items.create(params[:list_item])
    @list_item.save
    
    if @list_item.save && @list_item.rank == 5
      @list.published = 1
      @list.save
    end
    
    render :layout => false
  end
  
  def edit
    @list_item = ListItem.find(params[:id])
    
    if request.post?
      if @list_item.update_attributes(params[:list_item])
        redirect_to :controller => 'list_items', :action => 'ajax_view', :id => @list_item
        return
      end
    end
    render :layout => false
  end
  
  def ajax_view
    @list_item = ListItem.find(params[:id])
    render :layout => false
  end
end
