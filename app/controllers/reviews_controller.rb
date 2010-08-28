class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.xml
  
  before_filter :authorize_access, :except => [:public, :create_public]
  
  
  layout 'admin'
  
  def index
    @reviews = Review.find(:all, :order => 'merchant_id')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @review = Review.find(params[:id])
	
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.xml
  def new
    @review = Review.new
	@users = User.find(:all)
	@merchants = Merchant.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
    @users = User.find(:all)
    @merchants = Merchant.find(:all)
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @review = Review.new(params[:review])

    respond_to do |format|
      if @review.save
        flash[:notice] = 'Review was successfully created.'
        format.html { redirect_to(@review) }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        flash[:notice] = 'Review was successfully updated.'
        format.html { redirect_to(@review) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to(reviews_url) }
      format.xml  { head :ok }
    end
  end
 
  def public 
  	if session[:user_id]
	  	@review = Review.new
		@merchant = Merchant.find(params[:id])
		@merchants = Merchant.find(:all)
		@review.merchant_id = @merchant.id
		@user = User.find(session[:user_id])
		@review.user_id = @user.id
	  	render :layout => 'public'
  	else 
	  	flash[:notice] = "you can't make a new review unless you are logged in"
	  	redirect_to(:controller => 'public', :action => 'login' )
  	end
  
  end	
  
  def create_public 
  	
  	@review = Review.new(params[:review])
  	@review.user_id = session[:user_id]
  	@reviews = Review.find(:all)
  	user_id = @review.user_id
  	merchant_id = @review.merchant_id
  	
 	if Review.find(:first, :conditions => ["user_id = ? AND merchant_id = ?", user_id, merchant_id])
  		flash[:notice] = "you have already written a review for this guy!"
  		redirect_to(:controller => 'merchants', :action => 'public', :id => merchant_id )
  	else	
	  	if @review.save 
	  		flash[:notice] = 'Review was successfully created.'
	  		redirect_to(:controller => 'merchants', :action => 'public', :id => @review.merchant_id )
	  	else 
	  		flash[:notice] = "Something went wrong. Did not save."
	  		redirect_to(:controller => 'public', :action => 'list' )
	  	end
   end
  	
  	
  end
  
end
