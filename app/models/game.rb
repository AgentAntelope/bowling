class Game < ActiveRecord::Base
  has_many :players
  validate :has_players

  private
  def has_players
    if players.empty?
      errors.add(:players, "must exist")
    end
  end
end
