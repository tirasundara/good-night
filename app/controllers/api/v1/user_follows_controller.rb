module Api::V1
  class UserFollowsController < Api::BaseApiController

    # POST /api/v1/user_follows -- to follow a user
    def create
      user_follow = current_user.follow! user_follow_params[:followee_id]

      render json: UserFollowSerializer.new(user_follow).serializable_hash, status: :created
    end

    # DELETE /api/v1/user_follows/:followee_id -- to unfollow other user
    def destroy
      current_user.unfollow! params[:followee_id]

      render json: {}, status: :no_content
    end


    private

    def user_follow_params
      params.require(:user_follow).permit(:followee_id)
    end
  end
end
