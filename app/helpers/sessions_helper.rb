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
		session[:user_id] = user.id
	end

	# 8.2.2 in notes.txt

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def signed_in?
		!current_user.nil?
	end


end
