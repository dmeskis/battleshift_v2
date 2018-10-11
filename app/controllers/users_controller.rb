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
    user_logic = UserLogic.new(user_params)
    user = user_logic.single_user
    if user_logic.update_user
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
