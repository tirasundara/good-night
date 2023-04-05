module Api::V1
  class WakeUpTimesController < Api::BaseApiController

    # Sleep clock-out (Wake up) -- POST /api/v1/wake_up_times
    def create
      new_wake_up_time = current_user.log_wake_up! at: wake_up_time_params[:wake_up_ts]

      render json: WakeUpTimeSerializer.new(new_wake_up_time).serializable_hash, status: :created
    end


    private

    def wake_up_time_params
      params.permit(:wake_up_ts)
    end
  end
end
