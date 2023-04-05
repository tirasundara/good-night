FactoryBot.define do
  factory :wake_up_time do
    wake_up_ts { Time.now.midnight.utc + 5.hours }
  end
end
