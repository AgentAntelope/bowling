class GamesController < ApplicationController
  before_action :set_game, only: [:show, :destroy]

  # GET /games/1
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  def create
    @game = Game.new

    %i{player_1 player_2 player_3 player_4}.each do |player|
      unless params[player].blank?
        @game.players.build(name: params[player])
      end
    end

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to root_url, notice: 'Game was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end
end
