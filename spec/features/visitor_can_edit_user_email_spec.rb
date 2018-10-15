require 'rails_helper'

feature 'Guest user sees edits email for one user' do
  scenario 'only email address can be edited' do
    json_response = File.open("./fixtures/updated_users.json")
    stub_request(:get, "https://glacial-lake-90682.herokuapp.com/api/v1/users").
    to_return(status: 200, body: json_response)
    email = "josiah@example.com"

    visit "/users"
    within(".user-1") do
      click_on "Edit"
    end

    expect(current_path).to eq("/users/1/edit")

    fill_in :email, with: email
    click_on 'Save'
    expect(current_path).to eq("/users")
    expect(page).to have_content("Successfully updated Josiah Bartlet")
    within(".user-1") do
      expect(page).to have_content("josiah@example.com")
    end
    within(".user-1") do
      expect(page).to_not have_content("jbartlet@example.com")
    end
  end
end
