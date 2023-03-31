require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "#name" do
    context "when not present" do
      it "should be invalid" do
        user.name = ""

        expect(user).not_to be_valid
      end
    end
  end

  context "when present" do
    it "should be valid" do
      expect(user).to be_valid
    end
  end
end
