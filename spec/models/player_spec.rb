require 'rails_helper'

RSpec.describe Player, :type => :model do
  it { is_expected.to validate_presence_of(:name) }

  describe '#finished?' do
    it 'is true when there is a frame with position 10' do
      player = Player.new(name: 'fell')
      player.frames << Frame.new(position: 10)
      expect(player).to be_finished
    end

    it 'is false when there is only a frame with less than position 10' do
      player = Player.new(name: 'fell')
      player.frames << Frame.new(position: 9)
      expect(player).to_not be_finished
    end
  end

  describe '#on_final_frame?' do
    it 'is true when there is a frame with position 9' do
      player = Player.new(name: 'fell')
      player.frames << Frame.new(position: 9)
      expect(player).to be_on_final_frame
    end

    it 'is false when there is a frame with less than position 9' do
      player = Player.new(name: 'fell')
      player.frames << Frame.new(position: 8)
      expect(player).to_not be_on_final_frame
    end

    it 'is false when there is a frame with more than position 9' do
      player = Player.new(name: 'fell')
      player.frames << Frame.new(position: 10)
      expect(player).to_not be_on_final_frame
    end
  end

  describe '#grand_total_for_frame' do
    let(:player) { Player.new(name: 'fell') }
    before(:each) do
      player.frames << Frame.create(position: 1, first_score: 10)
      player.frames << Frame.create(position: 2, first_score: 9, second_score: 1)
      player.frames << Frame.create(position: 3, first_score: 5, second_score: 5)
      player.frames << Frame.create(position: 4, first_score: 7, second_score: 2)
      player.frames << Frame.create(position: 5, first_score: 10)
      player.frames << Frame.create(position: 6, first_score: 10)
      player.frames << Frame.create(position: 7, first_score: 10)
      player.frames << Frame.create(position: 8, first_score: 9)
      player.frames << Frame.create(position: 9, first_score: 8, second_score: 2)
      player.frames << Frame.create(position: 10, first_score: 9, second_score: 1, third_score: 10)
      player.save
    end

    it 'correctly totals a complex game' do
      expect(player.grand_total_for_frame(1)).to eq(20)
      expect(player.grand_total_for_frame(2)).to eq(35)
      expect(player.grand_total_for_frame(3)).to eq(52)
      expect(player.grand_total_for_frame(4)).to eq(61)
      expect(player.grand_total_for_frame(5)).to eq(91)
      expect(player.grand_total_for_frame(6)).to eq(120)
      expect(player.grand_total_for_frame(7)).to eq(139)
      expect(player.grand_total_for_frame(8)).to eq(148)
      expect(player.grand_total_for_frame(9)).to eq(167)
      expect(player.grand_total_for_frame(10)).to eq(187)
    end
  end
end
