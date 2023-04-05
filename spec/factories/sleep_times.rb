FactoryBot.define do
  factory :sleep_time do
    sleep_ts { Time.now.midnight.utc - 3.hours }
  end
end
