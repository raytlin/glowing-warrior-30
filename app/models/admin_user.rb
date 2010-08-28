class AdminUser < ActiveRecord::Base
	
	validates_presence_of :name, :password
	validates_uniqueness_of :name
	
	def self.login(name, password)
		self.find(:first, :conditions => ["name = ? AND password = ?", name, password])
	end
	
	def try_to_login 
		AdminUser.login(self.name, self.password)
	end		
	
end
