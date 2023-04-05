module Api::V1
  class SleepTimesController < Api::BaseApiController

    # GET /api/v1/sleep_times
    def index
      sleep_times = SleepTime.where(id: current_user.sleep_records.pluck(:sleep_time_id)).order(created_at: :desc)

      render json: SleepTimeSerializer.new(sleep_times).serializable_hash, status: :ok
    end

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
