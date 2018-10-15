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
      user = User.first
      expect(user.activated?).to eq(false)
      open_email('bob@mail.com')
      current_email.click_link "Activate"
      expect(current_email).to have_content("Here is your unique API key")
      expect(current_email).to have_content(user.api_key)
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Status: Active")
      updated_user = User.first
      expect(updated_user.activated?).to eq(true)
    end
  end
end
