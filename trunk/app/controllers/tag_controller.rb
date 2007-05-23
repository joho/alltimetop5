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
    @category_list = %w(one two three four five)
    @tags_count = List.tags_count()
  end
end
