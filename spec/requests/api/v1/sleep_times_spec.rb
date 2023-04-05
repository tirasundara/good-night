require 'rails_helper'

RSpec.describe "SleepTimes", type: :request do

  describe "GET /api/v1/sleep_times" do
    let!(:user) { create(:user, name: DEFAULT_USER_NAME) }

    before :each do
      user.log_sleep! at: Time.now.utc.midnight - 3.hours
      user.log_wake_up! at: Time.now.utc.midnight + 5.hours
    end

    it "returns http :ok code" do
      get "/api/v1/sleep_times"

      expect(response).to have_http_status(:ok)
    end

    it "returns correct json" do
      get "/api/v1/sleep_times"

      response_body = JSON.parse(response.body)
      expect(response_body["data"].size).to eq(1)
    end
  end

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
