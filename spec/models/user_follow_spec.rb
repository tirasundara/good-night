require 'rails_helper'

RSpec.describe UserFollow, type: :model do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let(:user_follow) { build(:user_follow, follower: user_2, followee: user_1) }

  describe "#follower_id" do
    it { should belong_to(:follower) }

    context "with invalid value" do
      it "should be invalid" do
        user_follow.follower_id = nil

        expect(user_follow).not_to be_valid
      end
    end

    context "with valid value" do
      it "should be valid" do

        expect(user_follow).to be_valid
      end
    end
  end

  describe "#followee_id" do
    it { should belong_to(:follower) }

    context "with invalid value" do
      it "should be invalid" do
        user_follow.followee_id = nil

        expect(user_follow).not_to be_valid
      end
    end

    context "with valid value" do
      it "should be valid" do

        expect(user_follow).to be_valid
      end
    end
  end
end
