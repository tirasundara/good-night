require 'rails_helper'

RSpec.describe "Ping", type: :request do
  describe "GET /ping" do
    
    it "returns http success status" do
      get "/ping"
      expect(response).to have_http_status(:success)
    end

    it "returns correct json response" do
      get "/ping"

      resp_body = JSON.parse(response.body)
      expect(resp_body["status"]).to eq("pong")
    end
  end
end
