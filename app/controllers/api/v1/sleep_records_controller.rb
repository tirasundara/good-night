module Api::V1
  class SleepRecordsController < Api::BaseApiController

    # GET list of friends' sleep records -- GET /api/v1/sleep_records?start_date=abc&end_date=def&sort_key=duration&sort_dir=-1
    def index
      sleep_records = sleep_record_query.call(**query_params)

      render json: SleepRecordSerializer.new(sleep_records).serializable_hash, status: :ok
    end


    private

    def query_params
      query = { user_ids: current_user.followee_ids }
      query.merge!(params.permit(:start_date, :end_date, :sort_key, :sort_dir))
      query
    end

    def sleep_record_query
      @sleep_record_query ||= SleepRecordQuery.new
    end
  end
end
