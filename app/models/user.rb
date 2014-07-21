class User < ActiveRecord::Base
	# Validate that a User has a name
	validates :name,presence: true, length: { maximum: 50 }
	validates :email,presence: true
end
