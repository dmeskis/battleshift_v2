class UsersController < ApplicationController

  def show
    @user = BattleshiftApi::User.new(params).single_user
  end

  def index
    @users = BattleshiftApi::User.new(params).many_users
  end

  def edit
    @user = BattleshiftApi::User.new(params).single_user
  end

  def update
    user = BattleshiftApi::User.new(params)
    if user.update_user
      user = user.single_user
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
      @user.send_activation_email
      flash[:success] = "Account successfully created!"
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:failure] = "Failed to register. Please try again."
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :name, :email, :password, :password_confirmation)
    end
end
