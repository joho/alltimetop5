class CommentsController < ApplicationController
  def create
    @list = List.find(params[:id])
    #post only for ajax form submission
    if request.post?
      @comment = Comment.new(params[:comment])
      @comment.list_id = @list.id
      @comment.user_id = session[:user].id
      @comment.save!
      unless request.xhr?
        redirect_to( :controller => 'browse', 
          :username => @list.username, 
          :action => 'visitlist',
          :id => @list )
      end
    else
      @comment = Comment.new
    end
    
    render :layout => false if request.xhr?
  end
  
  def login
    authorize
    if session[:user]
      list = List.find(params[:id], :include => [:user])
      url = url_for(:controller => 'browse', :action => 'visitlist', :username => list.user.username, :id => list) + '#comment'
      redirect_to url
    end
  end
end
