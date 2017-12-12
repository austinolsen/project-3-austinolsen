class UsersController < ApplicationController

include UsersHelper

  def index
    @users = User.all

  end

  def find_user
    @user = User.find_by(username:"#{params[:username]}")
      if @user.nil?
        redirect_to root_path
      else
      redirect_to @user
      end
  end

  def profile
    @user = User.find_by_id(params[:id])
    if current_user.nil?
      @saved_items = SavedItem.where(user_id:"#{params["id"]}")
    else
    @saved_items = SavedItem.where(user_id:current_user.id)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    login(@user)
    redirect_to user_path(@user.id)
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :password, :password_confirmation)
  end
end
