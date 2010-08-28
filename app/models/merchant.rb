class Merchant < ActiveRecord::Base
	
	has_many :reviews
	
	validates_presence_of :name, :web_address, :address, :zip, :state, :city
	validates_uniqueness_of :name, :web_address
	
end
