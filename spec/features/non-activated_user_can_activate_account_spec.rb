require 'rails_helper'

describe 'non-activated user' do
  describe 'clicks validation link in email' do
    it 'takes user to a page confirming your account is activated' do
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
    end
  end
end
