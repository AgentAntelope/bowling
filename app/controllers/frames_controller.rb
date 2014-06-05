class FramesController < ApplicationController
  def create
    player = Player.find(params[:player_id])

    Frame.create(
      first_score: params[:first_score],
      second_score: params[:second_score],
      third_score: params[:third_score],
      player_id: params[:player_id],
      position: player.next_frame_position
    )

    redirect_to player.game
  end
end
