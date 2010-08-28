class User < ActiveRecord::Base
	has_many :reviews
	validates_presence_of :email, :first_name, :last_name, :password, :image_path
	validates_uniqueness_of :email
	
	def self.login(email, password)
		self.find(:first, :conditions => ["email = ? AND password = ?", email, password])
	end
	
	def try_to_login 
		User.login(self.email, self.password)
	end		
end
