class UsersController < ApplicationController
  
  def new
  	@user = User.new
  end

  def show
    if logged_in?
  	   @user = User.find(params[:id])
    else
      render html: "Access denied"
    end 
  end

  def create
  	@user = User.new(user_params)
    #debugger
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to the Static Shock!"
  		redirect_to @user
  	else
  		render "new"
  	end
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password,
  								:password_confirmation)
 	end
end
