class UsersController < ApplicationController

  def show
    @user = UserLogic.new(user_params).single_user
  end

  def index
    @users = UserLogic.new(user_params).many_users
  end

  def edit
    @user = UserLogic.new(user_params).single_user
  end

  def update
    service = UserService.new(user_params)
    service.update_user
    user = User.new(service.find_user)
    if user
      flash[:success] = "Successfully updated #{user.name}."
    else
      flash[:failure] = "Failed to update user."
    end
    redirect_to users_path
  end

  private
    def user_params
      params.permit(:id, :name, :email)
    end
end
