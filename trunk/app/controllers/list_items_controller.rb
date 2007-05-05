class ListItemsController < ApplicationController
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy ],
         :redirect_to => { :controller => :lists }

  def destroy
    ListItem.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
