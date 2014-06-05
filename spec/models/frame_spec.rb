require 'rails_helper'

RSpec.describe Frame, :type => :model do
  it { is_expected.to validate_presence_of :position }
  it { should validate_uniqueness_of(:position).scoped_to(:player_id) }

  describe '#total_score' do
    let(:unremarkable_frame) { Frame.create(position: 2, first_score: 1, second_score: 2) }
    let(:spare) { Frame.create(position: 1, first_score: 1, second_score: 9) }
    let(:strike) { Frame.create(position: 1, first_score: 10, second_score: 0) }
    let(:triple_strike) { Frame.create(position: 10, first_score: 10, second_score: 10, third_score: 10) }
    let(:spare_and_strike) { Frame.create(position: 10, first_score: 9, second_score: 1, third_score: 10) }
    let(:player) { Player.new(name: 'fell') }

    it 'totals the scores correctly when there is no strike or spare' do
      player.frames << unremarkable_frame
      player.save
      expect(unremarkable_frame.total_score).to eq(3)
    end

    it 'totals the scores correctly when there was a spare' do
      player.frames << spare
      player.frames << unremarkable_frame
      player.save
      expect(spare.total_score).to eq(11)
    end

    it 'totals the scores correctly when there was a strike' do
      player.frames << strike
      player.frames << unremarkable_frame
      player.save
      expect(strike.total_score).to eq(13)
    end

    it 'totals a triple strike at the end of the game correctly' do
      player.frames << triple_strike
      player.save
      expect(triple_strike.total_score).to eq(30)
    end

    it 'totals a spare and a strike in the final frame correctly' do
      player.frames << spare_and_strike
      player.save
      expect(spare_and_strike.total_score).to eq(20)
    end
  end
end
