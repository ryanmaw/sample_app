module SessionsHelper

=begin
	This places a temporary cookie on the user's browser containing an encrypted version of the user's id.
	We can retrieve the id on the subsequent pages using " session[:user_id] ".
	When using the session method the cookie expires immidiently when the browser is closed.

	If we want it to be persistant between browser sessions (remember me login box) we must use a seperate cookies method.

	SECURITY CONCERNS: 

	The cookie created using the session method are automatically encrypted. This is pretty damn secure.
	If we use the cookie method we are vulnerable to "session hijacking"

	
=end

	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	# 8.2.2 in notes.txt


	# self.current_user = is the same as current_user=().  This is just a fancy assignment methode
	def current_user=(user)
		@current_user = user
	end

	# Finding the current user method
	# This calls the current user method the first time (database access) after that the user is remembered and return
	# Basically ||= is a fancy if statement
	def current_user
		@current_user ||= User.find_by_remeber_token(cookies[:remember_token])
	end

	def signed_in?
		
	end


end