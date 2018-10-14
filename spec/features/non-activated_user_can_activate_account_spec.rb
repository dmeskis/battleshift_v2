require 'rails_helper'

describe 'non-activated user' do
  describe 'clicks validation link in email' do
    it 'takes user to a page confirming your account is activated' do
      ActionMailer::Base.deliveries.clear

      username = "Bob"
      email = "Bob@mail.com"
      password = "password"

      visit '/'
      click_on "Register"
      fill_in :user_email, with: email
      fill_in :user_name, with: username
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password
      click_on "Submit"
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(User.count).to eq(1)
      user = User.first
      expect(user.activated?).to eq(false)
      binding.pry
      visit edit_account_activation_path(user.activation_token, email: user.email)
    #   get signup_path
    # assert_difference 'User.count', 1 do
    #   post users_path, params: { user: { name:  "Example User",
    #                                      email: "user@example.com",
    #                                      password:              "password",
    #                                      password_confirmation: "password" } }
    # end
    # assert_equal 1, ActionMailer::Base.deliveries.size
    # user = assigns(:user)
    # assert_not user.activated?
    # # Try to log in before activation.
    # log_in_as(user)
    # assert_not is_logged_in?
    # # Invalid activation token
    # get edit_account_activation_path("invalid token", email: user.email)
    # assert_not is_logged_in?
    # # Valid token, wrong email
    # get edit_account_activation_path(user.activation_token, email: 'wrong')
    # assert_not is_logged_in?
    # # Valid activation token
    # get edit_account_activation_path(user.activation_token, email: user.email)
    # assert user.reload.activated?
    # follow_redirect!
    # assert_template 'users/show'
    # assert is_logged_in?
    end
  end
end
