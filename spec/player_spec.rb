# frozen_string_literal: true

require_relative '../lib/player.rb'
describe Player do
  let(:player) { described_class.new('Aaron', 'A')}

  it 'should have a name' do
    expect(player).to have_attributes(name: 'Aaron')
  end

  it 'should have a disc' do
    expect(player).to have_attributes(disc: 'A')
  end
end