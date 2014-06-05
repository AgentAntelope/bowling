class Frame < ActiveRecord::Base

  FINAL_FRAME_POSITION = 10
  validates_presence_of :position
  validates_uniqueness_of :position, scope: :player_id

  belongs_to :player

  # validate score?

  # ensure scores are always numbers
  def first_score
    self[:first_score].to_i
  end

  def second_score
    self[:second_score].to_i
  end

  def third_score
    self[:third_score].to_i
  end

  def spare?
    (first_score + second_score == 10) && !strike?
  end

  def strike?
    first_score == 10
  end

  def final?
    position == FINAL_FRAME_POSITION
  end

  def total_score
    if final?
      return first_score + second_score + third_score
    end

    if strike?
      strike_score
    elsif spare?
      spare_score
    else
      first_score + second_score + third_score
    end
  end

  protected

  def next_frame
    player.frames.find_by(position: position + 1)
  end

  private

  def strike_score
    if next_frame
      if next_frame.strike?
        double_strike_score
      else
        next_frame.first_score + next_frame.second_score + 10
      end
    else
      0 # We don't know yet.
    end
  end

  def spare_score
    if next_frame
      next_frame.first_score + 10
    else
      0 # We don't know yet.
    end
  end

  def double_strike_score
    two_from_now = next_frame.next_frame
    if two_from_now
      20 + two_from_now.first_score + two_from_now.second_score
    else
      0 # We don't know yet.
    end
  end
end
