class UsersController < ApplicationController
  def index
    @users = User.all
    p @users
  end

  def show
    @user = current_user
  end
end
