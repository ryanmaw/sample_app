class SessionsController < ApplicationController
	def new
	end

	def create
	  user = User.find_by(email: params[:session][:email].downcase)
	  if user && user.authenticate(params[:session][:password])
	    # Sign the user in and redirect to the user's show page.
	    log_in user

	    # Rails automatically converts this to the route for the users profile page "user_path(user)"
	    redirect_to user

	  else
	    # Create an error message and re-render the signin form.
	    flash.now[:danger] = 'Invalid Email / Password Combination'
	    render 'new'
	  end
	end

	# 8.2.2 in notes.txt
	def log_in(user)
		session[:user_id] = user.id
	end

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def destroy
	end
end
