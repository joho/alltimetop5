class TagController < ApplicationController
  def search
    if request.post?
      @lists = List.find_tagged_with(:any => params[:search])
      
      # TODO: make this do that cool auto list thing 
      @search_terms = params[:search].split.join(', ')
    else
      redirect_to :action => 'browse'
    end
  end
  
  def browse
    @tags = Tag.find(:all)
  end
end
