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
	def signed_in_user 
	  # redirect_to signin_url, warning: "Please Sign In To Update Your Profile" unless signed_in?

	  # The code below == the code above.

	  unless signed_in?
	    store_location
	    flash[:warning] = "Please sign in."
	    redirect_to signin_url
	  end
	end
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	# self.current_user = is the same as current_user=().  This is just a fancy assignment method
	def current_user=(user)
		@current_user = user
	end

	# Finding the current user method
	# This calls the current user method the first time (database access) after that the user is remembered and return
	# Basically ||= is a fancy if statement
	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end
	def current_user?(user)
		# check that current user = user
		user == current_user
	end
	
	def signed_in?
		!current_user.nil?
		# True if signed in
	end

	def sign_out
		# set current_user to nil
		# delete the remember token
		self.current_user = nil
		cookies.delete(:remember_token)
	end


	# redirect back to or method with default args
	# the default is the root url

	def redirect_back_or(default)
		# redirect to the session[:return_to] || default
		redirect_to(session[:return_to] || default)
		# delete session cookie, delete is a method in the session class. Uses parentheses 
		session.delete(:return_to)

	end

	def store_location
		session[:return_to] = request.url
	end

end



















