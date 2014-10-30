class User < ActiveRecord::Base
	# Validate that a User has a name
	before_save { email.downcase! }
	before_save :create_remember_token
 	has_secure_password

	validates :name,presence: true, length: { maximum: 50 }
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
 	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }


	# Class Methods

	def User.digest(string)

		# IF Active Model is min_cost use min_cost ELSE use cost
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost

		# Create the password
		BCrypt::Password.create(string, cost: cost)
	end

	private

		def create_remember_token
			# Generate the token using SecureRandom method urlsafe_base64
			# The urlsafe_base64 method returns a string and we set it to the remember_token of the user 
			# The self keyword ensures that it gets saved to the user in the database and not just to a variable. 
			self.remember_token = SecureRandom.urlsafe_base64
		end


end
