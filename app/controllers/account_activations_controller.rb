class AccountActivationsController < ApplicationController

  def edit
    user = UserLogic.new(params).single_user
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = "Account activated!"
      redirect_to dashboard_path
    else
      flash[:failure] = "Invalid activation link"
      redirect_to dashboard_path
    end
  end
end
