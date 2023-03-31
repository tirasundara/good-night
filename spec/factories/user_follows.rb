FactoryBot.define do
  factory :user_follow do
    association :follower_id, factory: :user
    association :followee_id, factory: :user
  end
end
