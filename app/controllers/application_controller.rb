# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

private #--------------------------------------------------
  
  def authorize_access
  	unless session[:admin_user_id]
  	flash[:notice] = 'please log in'
  	redirect_to(:controller => 'admin', :action => 'index')
  	return false 
  	end
  end

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '0bce2013c0af4da7d0cad230ab98c63e'
end
