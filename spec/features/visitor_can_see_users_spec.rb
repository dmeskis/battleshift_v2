require 'rails_helper'

describe 'as a visitor' do
  describe 'visit /api/v1/users/:id' do
    it 'shows a users name and email address' do
      file = File.open("./fixtures/single_user.json")
      stub_request(:any, "http://localhost:3000").
        to_return(body: file, status: 200)

      visit "/users/1"

      expect(page).to have_content("Josiah Bartlet")
      expect(page).to have_content("jbartlet@example.com")

    end
    it 'shows multiple users name and email address' do

      file = File.open("./fixtures/multiple_users.json")
      stub_request(:get, "http://localhost:3000/api/v1/users").
        to_return(body: file, status: 200)

      visit "/users"

      expect(page).to have_content("Josiah Bartlet")
      expect(page).to have_content("jbarlet@example.com")
      expect(page).to have_content("Dylan Meskis")
      expect(page).to have_content("dmeskis@gmail.com")

    end
  end
end

# Title: Dogfooding GET /api/v1/users/:id
#
# Background: There is a user stored in the database with an id of 1, name of Josiah Bartlet, email of jbartlet@example.com
#
# As a guest user
# When I visit "/users/1"
# Then I should see the user's name Josiah Bartlet
# And I should see the user's email address jbartlet@example.com
