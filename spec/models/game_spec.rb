require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'relationships' do
    it {should belong_to(:opponent)}
    it {should belong_to(:challenger)}
  end
end
