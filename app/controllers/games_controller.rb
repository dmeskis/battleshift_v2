class GamesController < ApplicationController

  def new
    @users = User.all
  end

  def create
    conn =     Faraday.new(url: ENV["ROOT_URL"]) do |faraday|
                faraday.request  :url_encoded
                faraday.response :logger
                faraday.adapter Faraday.default_adapter
               end
    conn.post "/api/v1/games", { :opponent_email => params[:email], user_id: current_user.id }
  end
end
