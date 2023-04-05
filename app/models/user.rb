class User < ApplicationRecord
  include Followable

  has_many :sleep_records

  validates_presence_of :name

  # User#log_sleep! stores user's sleep clock-in data
  def log_sleep!(at: nil)
    at ||= Time.now.utc
    new_sleep_record = sleep_records.build
    new_sleep_record.create_sleep_time!(sleep_ts: at)
  end

  # User#log_wake_up! stores user's wake up time data
  def log_wake_up!(at: nil)
    at ||= Time.now.utc
    new_wake_up_time = WakeUpTime.new(wake_up_ts: at)
    sleep_records.update_or_create_by!(user: self, wake_up_time: new_wake_up_time)
    new_wake_up_time
  end
end
