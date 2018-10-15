class GamesController < ApplicationController

  def new
    @game = Game.new
    @users = User.all
  end

  def create

  end
end
