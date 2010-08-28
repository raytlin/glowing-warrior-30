class AdminController < ApplicationController

	before_filter :authorize_access, :except => [:index, :send_login]

  def index
  	@admin_user = AdminUser.new
  	if session[:admin_user_id]
  		redirect_to(:action => 'menu' )
  	end	
  end
  
  def login
  	@admin_user = AdminUser.new
  end	
  
  def send_login
 	@admin_user = AdminUser.new(params[:admin_user])
 	logged_in_admin_user = @admin_user.try_to_login
 	if logged_in_admin_user
 		session[:admin_user_id] = logged_in_admin_user.id
 		flash[:notice] = 'you are now logged in as an admin'
 		redirect_to(:action => 'menu')
 	else 
 		flash[:notice] = 'not logged in. username or password incorrect'
 		redirect_to(:action => 'index')
 	end	
  end
  
  def logout 
  	session[:admin_user_id] = nil 
  	flash[:notice] = "you are now logged out"
  	redirect_to(:action => 'index')
  end
  
  
  
  
end
