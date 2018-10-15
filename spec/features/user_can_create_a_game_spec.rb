require 'rails_helper'

describe 'user can create a game' do
  describe 'on new game page' do
    it 'user selects an email of another user to create a game' do
      user = create(:user, activated: 1)
      user_2 = create(:user, activated: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_game_path
      select user_2.email, from: "email"
      click_on "Create Game"

    end
  end
end
