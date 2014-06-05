require 'rails_helper'

RSpec.describe Game, :type => :model do
  it "validates players" do
    game = Game.new
    game.save
    expect(game.errors.full_messages.first).to match("Players must exist")
  end

  it "persists if players are present" do
    game = Game.new
    game.players << Player.new(name: 'fell')
    game.save
    expect(game).to be_persisted
  end
end
