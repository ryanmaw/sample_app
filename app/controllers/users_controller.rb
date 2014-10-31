 class UsersController < ApplicationController
  def new
  	@user = User.new
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
    if @user.update_attributes(user_params)
      # handle successful update
    else
      # rerender edit page with error message
      render 'edit'
    end
  end

  private 
  def user_params
  	params.require(:user).permit( :name, :email, :password, :password_confirmation)
  end

end
