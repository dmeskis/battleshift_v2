class AccountActivationsController < ApplicationController

  def edit
    user = UserLogic.new(params).single_user
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, 1)
      user.update_attribute(:activated_at, Time.zone.now)
      flash[:success] = "Account activated!"
      redirect_to dashboard_path
    else
      flash[:failure] = "Invalid activation link"
      redirect_to dashboard_path
    end
  end
end
