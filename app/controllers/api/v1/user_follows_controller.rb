module Api::V1
  class UserFollowsController < Api::BaseApiController

    def create
      user_follow = current_user.follow! user_follow_params[:followee_id]
      render json: UserFollowSerializer.new(user_follow).serializable_hash, status: :created
    end


    private

    def user_follow_params
      params.require(:user_follow).permit(:followee_id)
    end
  end
end
