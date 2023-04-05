module Api::V1
  class SleepRecordSerializer
    include JSONAPI::Serializer

    attributes :id, :user_id, :created_at
    attribute :sleep_ts
    attribute :wake_up_ts
    attribute :duration
  end
end
