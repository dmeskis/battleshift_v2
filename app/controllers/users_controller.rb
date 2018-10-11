class UsersController < ApplicationController

  def show
    @user = UserLogic.new(params).single_user
  end

  def index
    @users = UserLogic.new(params).many_users
  end

  def edit
    @user = UserLogic.new(params).single_user
  end

  def update
    user_logic = UserLogic.new(params)
    user = user_logic.single_user
    if user_logic.update_user
      flash[:success] = "Successfully updated #{user.name}."
    else
      flash[:failure] = "Failed to update user."
    end
    redirect_to users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Account succesfully created!"
      redirect_to dashboard_path
    else
      flash[:failure] = "Failed to register. Please try again."
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :name, :email, :password)
    end
end
