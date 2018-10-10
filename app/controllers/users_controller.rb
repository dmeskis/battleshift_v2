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
end
