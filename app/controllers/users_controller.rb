 class UsersController < ApplicationController
  before_filter :signed_in_user,    only: [:index ,:edit , :update, :destroy]
  before_filter :correct_user,      only: [:edit, :update]
  before_filter :admin_user,        only: [:destroy]


  def new
    if !signed_in?
    	@user = User.new
    else
      redirect_to root_url
      @user = current_user
      flash[:danger] = "You cannot access the signup page because you are already signed in. Current Username: #{@user.name}"
    end
  end


  def create 
  	# @user = User.new(user_params)  
  	@user = User.new(user_params) 
  	if @user.save

      sign_in @user # signs the user in upon successful registration
      flash[:success] = "You have succesfully registered!"
      redirect_to @user

  	else
  		render 'new'
  	end

  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params) # This differs from the book because of the strong params in rails 4
      # handle successful update
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      # rerender edit page with error message
      render 'edit'
    end
  end
  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_url
  end


  private 



  def user_params
  	params.require(:user).permit(* user_attributes)
  end

  def user_attributes
    [:name, :email, :password, :password_confirmation]
  end

  # Create a before_filter
  # This allows the authentication to take place before

  def signed_in_user 
    # redirect_to signin_url, warning: "Please Sign In To Update Your Profile" unless signed_in?

    # The code below == the code above.

    unless signed_in?
      store_location
      flash[:warning] = "Please sign in."
      redirect_to signin_url
    end
  end

  # Signd in users should not be allowed to access create and new when already signed in






  def correct_user
    # get user id
    @user = User.find(params[:id])
    # if user display page if not redirect to root
    redirect_to(root_url) unless current_user?(@user)
  end 


  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
