require 'rails_helper'

RSpec.describe "UserFollows", type: :request do
  let!(:follower) { create(:user, name: DEFAULT_USER_NAME) }
  let!(:followee) { create(:user, name: "alice") }

  describe "POST /api/v1/user_follows" do
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

  describe "DELETE /api/v1/user_follows/:followee_id" do
    before(:each) do
      follower.follow! followee.id
    end

    context "with valid followee_id" do
      it "returns http no_content status" do
        delete "/api/v1/user_follows/#{followee.id}"

        expect(response).to have_http_status(:no_content)
      end
  
      it "returns empty response body" do
        delete "/api/v1/user_follows/#{followee.id}"
  
        expect(response.body).to be_empty
      end
    end

    context "with invalid followee_id" do
      it "returns http not_found status" do
        delete "/api/v1/user_follows/0"

        expect(response).to have_http_status(:not_found)
      end
  
      it "returns correct json response" do
        delete "/api/v1/user_follows/0"
  
        resp_body = JSON.parse(response.body)
        expect(resp_body["errors"][0]["status"]).to eq(404)
        expect(resp_body["errors"][0]["title"]).to eq("Record not Found")
      end
    end
  end
end
