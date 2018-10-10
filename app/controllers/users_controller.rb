class UsersController < ApplicationController

  def show
    service = UserService.new(params)
    @user = User.new(service.find_user)
  end

  def index
    service = UserService.new(params)
    users = service.all_users
    @users = users.map {|user| User.new(user)}
  end

  def edit
    service = UserService.new(params)
    @user = User.new(service.find_user)
  end

  def update
    service = UserService.new(params)
    service.update_user
    user = User.new(service.find_user)
    if user
      flash[:success] = "Successfully updated #{user.name}."
    else
      flash[:failure] = "Failed to update user."
    end
    redirect_to users_path
  end
end
