class User < ActiveRecord::Base
	# Validate that a User has a name
	validates :name,presence: true
	validates :email,presence: true
end
