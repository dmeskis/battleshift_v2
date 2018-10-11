require 'rails_helper'

describe 'as a visitor' do
  describe 'on a users show page' do
    it 'lets visitor click edit where they are taken to that users edit page' do
      file = File.open("./fixtures/multiple_users.json")
      stub_request(:get, "https://polar-refuge-52259.herokuapp.com/api/v1/users").
        to_return(body: file, status: 200)

      visit "/users"
      within(".user-1") do
        click_on "Edit"
      end
      expect(current_path).to eq("/users/1/edit")
    end
    it 'lets visitor edit a user' do
      visit "/users/1/edit"
      fill_in :email, with: "josiah@example.com"

      click_on "Save"

      # This should have request has %40 because that is the URL-encoded version
      # for the @ character. Faraday is sending our patch request with the URL-
      # encoded body so it translates it to %40.
      should have_requested(:patch, "https://polar-refuge-52259.herokuapp.com/api/v1/users/1").
        with(:body => "email=josiah%40example.com").once

      expect(current_path).to eq("/users")
      within(".user-1") do
        expect(page).to have_content("josiah@example.com")
      end

      expect(page).to have_content("Successfully updated Josiah Bartlet.")
    end
  end
end
