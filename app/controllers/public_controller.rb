class PublicController < ApplicationController
	
	def list 
		@reviews = Review.find(:all, :order => 'created_at DESC')
	end
	
	def login
  	@users = User.new
 	end
  
    def send_login
 		@user = User.new(params[:user])
 		
 		logged_in_user = @user.try_to_login
 	if logged_in_user
 		session[:user_id] = logged_in_user.id
 		session[:user_name] = logged_in_user.first_name
 		flash[:notice] = 'you are now logged in bro!'
 		merchant_id = session[:merchant_id]
 		if merchant_id == 0
 			redirect_to(:controller => 'public', :action => 'list' )
 		else 
 			redirect_to(:controller => 'reviews', :action => 'public', :id => merchant_id)
 		end	
 	else 
 		flash[:notice] = 'not logged in. username or password incorrect'
 		redirect_to(:controller => 'public', :action => 'list')
 	end	
  end
  
  def logout 
  	session[:user_id] = nil 
  	session[:user_name] = nil
  	flash[:notice] = "ya got yourself logged out, fool!"
  	redirect_to(:action => 'list')
  end
  
  def signup
  	@user = User.new
  	
  	#random image generator ------------
  	picnum = 1 + rand(94)
    if picnum <= 9 then
    	picnum = "0" + picnum.to_s + ".jpg"
    else 
   	picnum = picnum.to_s + ".jpg"
   	end
   	
    @user.image_path = picnum	

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end
  
  def send_signup
  	@user = User.new(params[:user])	
  	if @user.save 
  		flash[:notice] = "congratulations! you're our newest user perhaps!"
  		redirect_to(:action => 'list')
  	else 
  		flash[:notice] = "sign up failed. danged if i know why. did you not fill everything in? just try again or something"
  		redirect_to(:action => 'list')
  	end
  end
 
  def allmerchants
  	@merchants = Merchant.find(:all, :order => 'name ASC')  	
  end
  
  def newmerchant
  	if session[:user_id]
	  	@merchant = Merchant.new 
	  	@merchant.address = 'street address'
	    @merchant.city = 'city'
	    @merchant.zip = 'zip code'
	    @merchant.state = 'state' 
	else 
	  	flash[:notice] = "you can't submit a new business unless you are logged in ya bozo"
	  	redirect_to(:controller => 'public', :action => 'login' )
	end  	    
  end

  def send_merchant
  	@merchant = Merchant.new(params[:merchant])
  	@merchant.image_path = "http://localthaifood.moxyfy.com/images/default_avatar.gif"
	if @merchant.save 
  		flash[:notice] = "congratulations! you made a new merchant I think!"
  		redirect_to(:action => 'list')
  	else 
  		flash[:notice] = "new merchant creation failed. danged if i know why. did you not fill everything in? maybe this business is already in our extensive database."
  		redirect_to(:action => 'newmerchant')
  	end
   end	
   
   def rank_up 
  	@review = Review.find(params[:id])
  	@review.position = @review.position + 1 
  	if @review.update_attributes(params[:review])
        flash[:notice] = 'Review was successfully updated.'
  	redirect_to(:controller => 'merchants', :action => 'public', :id => @review.merchant_id )
  	else 
  		flash[:notice] = "rank thing is broken"
  		redirect_to(:controller => 'merchants', :action => 'public', :id => @review.merchant_id )
  		end
  end
 
  def rank_down 
  	@review = Review.find(params[:id])
  	@review.position = @review.position - 1 
  	if @review.update_attributes(params[:review])
        flash[:notice] = 'Review was successfully updated.'
  	redirect_to(:controller => 'merchants', :action => 'public', :id => @review.merchant_id )
  	else 
  		flash[:notice] = "rank thing is broken"
  		redirect_to(:controller => 'merchants', :action => 'public', :id => @review.merchant_id )
  		end
  end
end
