class User < ApplicationRecord
  has_secure_password
  has_many :saved_items, dependent: :destroy
  validates :username, presence: true, uniqueness: true, length: {minimum: 6}

  def self.confirm(params)
    @user = User.find_by({username: params[:username]})
    @user ? @user.authenticate(params[:password]) : false
  end
end
