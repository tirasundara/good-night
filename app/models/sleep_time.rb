class SleepTime < ApplicationRecord
  after_initialize :assign_default_timestamp, if: ->(record) { record.sleep_ts.nil? }

  has_one :sleep_record, autosave: true

  private

  def assign_default_timestamp
    self.sleep_ts = Time.now.utc
  end
end
