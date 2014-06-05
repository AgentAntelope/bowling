class Player < ActiveRecord::Base
  belongs_to :game
  has_many :frames
  validates_presence_of :name

  def finished?
    next_frame_position > 10
  end

  def on_final_frame?
    next_frame_position == 10
  end

  def grand_total_for_frame(position)
    grand_total = 0

    position.times do |frame_position|
      grand_total += frames.find_by(position: frame_position + 1).total_score
    end

    grand_total
  end

  def next_frame_position
    last_frame_position + 1
  end

  private

  def last_frame_position
    frames.map(&:position).max.to_i
    # if we don't have any frames, this will be nil, so return 0
  end

end
