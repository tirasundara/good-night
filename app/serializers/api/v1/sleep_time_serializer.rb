module Api::V1
  class SleepTimeSerializer
    include JSONAPI::Serializer
  
    attributes :id, :sleep_ts, :created_at
  end
end
