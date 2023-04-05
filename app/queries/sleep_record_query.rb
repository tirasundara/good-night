class SleepRecordQuery < BaseQuery

  SORT_KEYS_MAP = {
    "id" => :id,
    "user_id" => :user_id,
    "created_at" => :created_at,
    "duration" => :duration
  }.freeze

  SORT_DIRECTIONS_MAP = {
    "asc" => :asc,
    "1" => :asc,
    "desc" => :desc,
    "-1" => :desc
  }.freeze

  def initialize(scope: nil, **options)
    @scope = scope || default_scope
  end

  def call(user_ids: nil, start_date: nil, end_date: nil, sort_key: nil, sort_dir: nil, **filters)
    scoped = @scope
    scoped = filter_by_user_ids(scoped, user_ids)
    scoped = filter_by_date_ranges(scoped, start_date: start_date, end_date: end_date)
    scoped = sort_by(scoped, key: sort_key, dir: sort_dir)

    scoped
  end


  private

  def default_scope
    @default_scope ||= SleepRecord.joins(:sleep_time, :wake_up_time).select(default_select)
  end

  def default_select
    @default_select ||= <<-EOS.gsub(/^[\s\t]*|[\s\t]*\n/, '') # no space "\s" for new line "\n"; kill tabs too
      sleep_records.id, sleep_records.user_id, sleep_records.created_at, 
      sleep_times.sleep_ts AS sleep_ts, wake_up_times.wake_up_ts AS wake_up_ts, 
      (wake_up_times.wake_up_ts - sleep_times.sleep_ts) AS duration
    EOS
  end

  def filter_by_user_ids(scoped, user_ids)
    scoped.where(user_id: Array(user_ids))
  end

  def filter_by_date_ranges(scoped, start_date:, end_date:)
    return scoped if start_date.blank? || end_date.blank?

    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)
    scoped.where(created_at: (start_date..end_date))
  end

  def sort_by(scoped, key: nil, dir: nil)
    key = SORT_KEYS_MAP.fetch("#{key}".downcase, :created_at)
    dir = SORT_DIRECTIONS_MAP.fetch("#{dir}".downcase, :desc)

    scoped.order(key => dir)
  end
end
