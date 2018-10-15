require 'rails_helper'

describe 'on the landing page' do
  describe 'as a visitor' do
    it 'allows me to register and be logged into a dashboard' do
      username = "Bob"
      email = "Bob@mail.com"
      password = "password"

      visit '/'
      click_on "Register"
      
      expect(current_path).to eq(register_path)
      
      fill_in :user_email, with: email
      fill_in :user_name, with: username
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: password
      click_on "Submit"

      expect(User.count).to eq(1)
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Account successfully created!")
      expect(page).to have_content("Logged in as #{username}")
      expect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
    it 'can fail to register if passwords do not match' do
      username = "Bob"
      email = "Bob@mail.com"
      password = "password"

      visit '/'
      click_on "Register"
      
      expect(current_path).to eq(register_path)
      
      fill_in :user_email, with: email
      fill_in :user_name, with: username
      fill_in :user_password, with: password
      fill_in :user_password_confirmation, with: "123"
      click_on "Submit"

      expect(page).to have_content("Failed to register. Please try again.")
    end
  end
end
