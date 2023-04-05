require 'rails_helper'

RSpec.describe "SleepRecords", type: :request do
  describe "GET /api/v1/sleep_records" do
    it "returns http success code" do
      get "/api/v1/sleep_records"

      expect(response).to have_http_status(:ok)
    end

    context "when there is no match data" do
      it "returns empty data" do
        get "/api/v1/sleep_records?sort_by=duration&sort_key=-1"

        response_body = JSON.parse(response.body)
        expect(response_body["data"]).to be_empty
      end
    end
  end
end
