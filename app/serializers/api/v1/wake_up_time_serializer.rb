module Api::V1
  class WakeUpTimeSerializer
    include JSONAPI::Serializer
  
    attributes :id, :wake_up_ts, :created_at
  end
end
