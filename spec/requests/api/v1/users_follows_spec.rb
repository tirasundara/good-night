require 'rails_helper'

RSpec.describe "UserFollows", type: :request do
  describe "POST /api/v1/user_follows" do
    let!(:follower) { create(:user, name: "Bob") }
    let!(:followee) { create(:user, name: "Alice") }
    let(:user_follow_params) do
      {
        followee_id: followee.id
      }
    end

    context "with valid params" do
      it "returns http created status" do
        post "/api/v1/user_follows", params: { user_follow: user_follow_params }

        expect(response).to have_http_status(:created)
      end
  
      it "returns correct json response" do
        post "/api/v1/user_follows", params: { user_follow: user_follow_params }
  
        resp_body = JSON.parse(response.body)
        expect(resp_body["data"]["attributes"]["follower_id"]).to eq(follower.id)
        expect(resp_body["data"]["attributes"]["followee_id"]).to eq(followee.id)
      end
    end

    context "with invalid params" do
      it "returns http unprocessable_entity status" do
        post "/api/v1/user_follows", params: { user_follow: { followee_id: 0 } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
  
      it "returns correct json response" do
        post "/api/v1/user_follows", params: { user_follow: { followee_id: 0 } }
  
        resp_body = JSON.parse(response.body)
        expect(resp_body["errors"][0]["status"]).to eq(422)
        expect(resp_body["errors"][0]["title"]).to eq("Unprocessable Entity")
        expect(resp_body["errors"][0]["detail"]).to eq("Validation failed: Followee must exist")
      end
    end
  end
end
