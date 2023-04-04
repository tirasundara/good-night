require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "associations" do
    it { should have_many(:user_followees) }
    it { should have_many(:user_followers) }
    it { should have_many(:followers).through(:user_followees) }
    it { should have_many(:followees).through(:user_followers) }
  end

  describe "#name" do
    context "when not present" do
      it "should be invalid" do
        user.name = ""

        expect(user).not_to be_valid
      end
    end

    context "when present" do
      it "should be valid" do
        expect(user).to be_valid
      end
    end
  end

  describe "#follow!" do
    let!(:followee) { create(:user, name: "Followee") }
    before { user.save! }

    context "with valid followee_id" do

      it "should return UserFollow instance" do
        user_follow = user.follow! followee.id

        expect(user_follow).to be_an_instance_of(UserFollow)
        expect(user_follow.follower_id).to eq(user.id)
        expect(user_follow.followee_id).to eq(followee.id)
      end

      it "adds one Followee" do
        expect {
          user.follow! followee.id
      }.to change { user.followees.count }.by(1)
      end
    end

    context "when invoked multiple times with the same followee_id" do
      it "should only create one instance of UserFollow" do
        user.follow! followee.id  # 1st time

        expect {
          user.follow! followee.id  # 2nd time
        }.not_to change { user.followees.count }
      end
    end

    context "with invalid followee_id" do
      let(:invalid_followee_id) { 0 }
      it "should raise ActiveRecord::RecordInvalid error" do
        expect {
          user.follow! invalid_followee_id
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe "#unfollow!" do
    let!(:followee) { create(:user, name: "Followee") }
    before(:each) do
      user.save!
      user.follow! followee.id
    end

    context "with valid followee_id" do
      it "should return UserFollow instance" do
        user_follow = user.unfollow! followee.id

        expect(user_follow).to be_an_instance_of(UserFollow)
        expect(user_follow.follower_id).to eq(user.id)
        expect(user_follow.followee_id).to eq(followee.id)
      end

      it "should decrease User#followees by 1" do
        expect {
          user.unfollow! followee.id
      }.to change { user.followees.count }.by(-1)
      end
    end

    context "when invoked multiple times with the same followee_id" do
      it "should only delete one instance of UserFollow and raise ActiveRecord::RecordNotFound error" do
        user.unfollow! followee.id  # 1st time

        expect {
          user.unfollow! followee.id  # 2nd time
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "with invalid followee_id" do
      let(:invalid_followee_id) { 0 }
      it "should raise ActiveRecord::RecordNotFound error" do
        expect {
          user.unfollow! invalid_followee_id
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
