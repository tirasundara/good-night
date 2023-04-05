FactoryBot.define do
  factory :sleep_record do
    association :sleep_time, factory: :sleep_time
    association :wake_up_time, factory: :wake_up_time
    association :user, factory: :user
  end
end
