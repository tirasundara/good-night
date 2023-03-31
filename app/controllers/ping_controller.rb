class PingController < ApplicationController
  def ping
    render json: { status: :pong }
  end
end
