class User < ApplicationRecord
  has_secure_password
  has_many :saved_item, dependent: :destroy

  def self.confirm(params)
    @user = User.find_by({username: params[:username]})
    @user ? @user.authenticate(params[:password]) : false
  end
end
