require 'rails_helper'

describe 'on the landing page' do
  describe 'as a visitor' do
    it 'allows me to register and be logged into a dashboard' do
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
      fill_in :email_address, with: email
      fill_in :username, with: username
      fill_in :password, with: password
      fill_in :password_confirmation, with: "123"
      click_on "Submit"

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Failed to register. Please try again.")
    end
  end
end

# As a guest user
# When I visit "/"
# And I click "Register"
# Then I should be on "/register"
# And when I fill in an email address (required)
# And I fill in name (required)
# And I fill in password and password confirmation (required)
# And I click submit
# Then I should be redirected to "/dashboard"
# And I should see a message that says "Logged in as <SOME_NAME>"
# And I should see "This account has not yet been activated. Please check your email."
