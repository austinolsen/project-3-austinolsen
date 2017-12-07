class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:username, :password)
    @user = User.confrim(user_params)
    if @user
      login(@user)
      redirect_to @user
    else
      redirect_to login_path
   end
 end

  def destroy
    logout
    redirect_to root_path
  end
end