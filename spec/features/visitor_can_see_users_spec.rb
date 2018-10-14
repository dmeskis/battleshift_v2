require 'rails_helper'

describe 'as a visitor' do
  describe 'visit users show and index pages' do
    it 'shows a users name and email address' do
      file = File.open("./fixtures/single_user.json")
      stub_request(:get, "#{ENV["ROOT_URL"]}/api/v1/users/1").
        to_return(body: file, status: 200)
      visit "/users/1"

      expect(page).to have_content("Josiah Bartlet")
      expect(page).to have_content("jbartlet@example.com")

    end
    it 'shows multiple users name and email address' do

      file = File.open("./fixtures/multiple_users.json")
      stub_request(:get, "#{ENV["ROOT_URL"]}/api/v1/users").
        to_return(body: file, status: 200)

      visit "/users"

      expect(page).to have_content("Josiah Bartlet")
      expect(page).to have_content("jbarlet@example.com")
      expect(page).to have_content("Dylan Meskis")
      expect(page).to have_content("dmeskis@gmail.com")

    end
  end
end
