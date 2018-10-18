require 'rails_helper'

describe BattleshiftApi::User, type: :model do
  it 'exists' do
    user = BattleshiftApi::User.new()

    expect(user).to be_a(BattleshiftApi::User)
  end

  context 'instance methods' do
    context 'single_user' do
      it 'returns a single user' do
        user = BattleshiftApi::User.new(id: 1)
        expect(user.single_user).to be_a(User)
      end
    end
    
    context 'many_user' do
      it 'returns many users' do
        user = BattleshiftApi::User.new()
        users = user.many_users
        expect(users.count).to be > 1
        expect(users).to all be_a User
      end
    end
  end
end
