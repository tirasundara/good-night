class SleepRecord < ApplicationRecord
  scope :by_last_week, -> () { where(created_at: Time.now.utc.last_week.beginning_of_week..Time.now.utc.last_week.end_of_week) }
  scope :order_by_duration, -> () { joins(:user, :sleep_time, :wake_up_time).select("sleep_records.id, sleep_records.created_at, sleep_records.user_id, sleep_times.sleep_ts, wake_up_times.wake_up_ts, (wake_up_times.wake_up_ts - sleep_times.sleep_ts) AS duration").order("duration ASC") }

  belongs_to :user
  belongs_to :sleep_time, optional: true
  belongs_to :wake_up_time, optional: true

  def self.update_or_create_by!(user:, wake_up_time:)
    sleep_record = joins(:user, :sleep_time).where(user: user).where("sleep_times.sleep_ts <= ?", Time.at(wake_up_time.wake_up_ts).utc).order(created_at: :desc).first

    # create a new sleep_record if there is no match
    return create!(user: user, wake_up_time: wake_up_time) if sleep_record.nil?

    # there is a matched sleep_record
    # assign sleep_record#wake_up_time and update it
    sleep_record.wake_up_time = wake_up_time
    sleep_record.save!
    sleep_record
  end

end
