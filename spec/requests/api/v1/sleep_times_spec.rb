require 'rails_helper'

RSpec.describe "SleepTimes", type: :request do

  describe "POST /api/v1/sleep_times" do
    it "returns http :created code" do
      post "/api/v1/sleep_times", params: { sleep_ts: Time.now.utc }

      expect(response).to have_http_status(:created)
    end

    it "returns correct json" do
      post "/api/v1/sleep_times", params: { sleep_ts: Time.now.utc }

      response_body = JSON.parse(response.body)
      expect(response_body["data"]["attributes"]).to be_present
    end
  end
end
