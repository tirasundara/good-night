module Api::V1
  class SleepTimesController < Api::BaseApiController

    # Sleep clock-in -- POST /api/v1/sleep_times
    def create
      new_sleep_time = current_user.log_sleep! at: sleep_time_params[:sleep_ts]

      render json: SleepTimeSerializer.new(new_sleep_time).serializable_hash, status: :created
    end


    private

    def sleep_time_params
      params.permit(:sleep_ts)
    end
  end
end
