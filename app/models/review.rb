class Review < ActiveRecord::Base
	
	belongs_to :merchant
	belongs_to :user
	
	validates_presence_of :comment, :score, :merchant_id, :user_id
	
	
	
end
