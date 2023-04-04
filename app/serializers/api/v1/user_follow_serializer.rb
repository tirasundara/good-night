module Api::V1
  class UserFollowSerializer
    include JSONAPI::Serializer
  
    attributes :id, :follower_id, :followee_id, :created_at
  end
end
