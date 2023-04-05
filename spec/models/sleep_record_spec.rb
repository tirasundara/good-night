require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  describe "associations" do
    it { should belong_to(:sleep_time).optional }
    it { should belong_to(:wake_up_time).optional }
    it { should belong_to(:user) }
  end
end
