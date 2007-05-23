# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
  def authorize
    unless session[:user]
      flash[:notice] = "You need to log in or register first!"
      session[:original_uri] = request.request_uri
      redirect_to :controller => 'users', :action => 'login'
    end
  end
end