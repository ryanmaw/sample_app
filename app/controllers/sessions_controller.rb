class SessionsController < ApplicationController
	def new
		if signed_in?
		   redirect_to root_url
		   flash[:danger] = 'You can not access the signin page because you are already signed in.  Sign out to Signin as another user.'
		else
		end
	end

	def create
		  user = User.find_by(email: params[:session][:email].downcase)
		  if user && user.authenticate(params[:session][:password])
		    # Sign the user in and redirect to the user's show page.
		    sign_in user

		    # Rails automatically converts this to the route for the users profile page "user_path(user)"
		    redirect_back_or user

		  else
		    # Create an error message and re-render the signin form.
		    flash.now[:danger] = 'Invalid Email / Password Combination'
		    render 'new'
		  end
	end




	def destroy
		sign_out
		redirect_to root_url # redirect to home page

	end
end
