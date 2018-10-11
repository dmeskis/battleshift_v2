require 'rails_helper'

describe UserLogic, type: :model do
  it 'exists' do
    user_logic = UserLogic.new()

    expect(user_logic).to be_a(UserLogic)
  end

  context 'instance methods' do
    context 'single_user' do
      it 'returns a single user' do
        logic = UserLogic.new(id: 1)
        expect(logic.single_user).to be_a(User)
      end
    end
    context 'many_user' do
      it 'returns many users' do
        logic = UserLogic.new()
        users = logic.many_users
        expect(users.count).to be > 1
        expect(users).to all be_a User
      end
    end
  end
end
