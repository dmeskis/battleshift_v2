require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}

  describe 'status' do
    it 'is is unactivated upon creation' do
      user = create(:user)

      expect(user.status).to eq("unactivated")
      expect(user.activated?).to be_falsey
    end

    it 'can be activated' do
      user = create(:user, status: 1)

      expect(user.status).to eq("activated")
      expect(user.activated?).to be_truthy
    end
  end
end
