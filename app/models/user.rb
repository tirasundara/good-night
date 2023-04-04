class User < ApplicationRecord
  has_many :user_followees, foreign_key: :followee_id, class_name: "UserFollow"
  has_many :user_followers, foreign_key: :follower_id, class_name: "UserFollow"

  # list of followers or list of users who follows the user
  has_many :followers, through: :user_followees, class_name: "User"

  # list of users followed by the user
  has_many :followees, through: :user_followers, class_name: "User"

  validates_presence_of :name

  def follow!(followee_id)
    user_followers.find_or_create_by!(followee_id: followee_id)
  end

  def unfollow!(followee_id)
    user_follow = user_followers.find_by!(followee_id: followee_id)
    user_follow.destroy
  end
end
