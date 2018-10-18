require 'spec_helper'
require './app/services/values/space'
require './app/services/values/ship'

describe Space do
  let(:space) { Space.new("A1") }
  let(:ship) { Ship.new(1) }

  it "exists" do
    expect(space).to be_a Space
  end

  it 'occupy!' do
    space.occupy!(ship)
    expect(space.contents).to eq(ship)
  end

  it 'attack!' do
    space.attack!
    expect(space.status).to eq("Miss")
  end

  it 'occupied' do
    expect(space.occupied?).to eq(false)
  end

  it 'not_attacked?' do
    expect(space.not_attacked?).to eq(true)
  end

end
