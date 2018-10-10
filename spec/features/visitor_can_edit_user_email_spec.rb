require 'rails_helper'

describe 'as a visitor' do
  describe 'on a users show page' do
    it 'lets visitor click edit where they are taken to that users edit page' do
      file = File.open("./fixtures/multiple_users.json")
      stub_request(:get, "http://localhost:3000/api/v1/users").
        to_return(body: file, status: 200)

      visit "/users"
      within(".user-1") do
        click_on "Edit"
      end
      expect(current_path).to eq("/users/1/edit")
    end
    it 'lets visitor edit a user' do
      # file = File.open("./fixtures/multiple_users.json")
      # stub_request(:get, "http://localhost:3000/api/v1/users").
      #   to_return(body: file, status: 200)

      visit "/users/1/edit"
      fill_in :email, with: "josiah@example.com"
      click_on "Save"

      expect(current_path).to eq("/users")
      within(".user-1") do
        expect(page).to have_content("josiah@example.com")
      end
      expect(page).to have_content("Successfully updated Josiah Bartlet.")
    end
  end
end

# Title: Build PATCH /api/v1/users/:id
#
# API should only support changing a users's email address
# Title: Edit a user's email address (dogfooding PATCH /api/v1/users/:id)
#
# Background: There is a user stored in the database with an id of 1, name of Josiah Bartlet, email of jbartlet@example.com
#
# As a guest user
# When I visit "/users"
# And I click on `Edit` for Josiah Bartlet
# Then I should be on "/users/1/edit"
#
# When I fill in the email field with "josiah@example.com"
# And I click "Save"
# Then I should be on "/users"
# And I should see a flash message that says "Successfully updated Josiah Bartlet."
# And I should should see Josiah Bartlet's email show up in the list as "josiah@example.com"
