class WakeUpTime < ApplicationRecord
  after_initialize :assign_default_timestamp, if: ->(record) { record.wake_up_ts.nil? }

  has_one :sleep_record


  private

  def assign_default_timestamp
    self.wake_up_ts = Time.now.utc
  end
end
