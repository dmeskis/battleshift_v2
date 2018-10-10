class UsersController < ApplicationController

  def show
    service = UserService.new(params)
    @user = User.new(service.find_user)
  end
end
