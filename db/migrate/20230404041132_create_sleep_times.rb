class CreateSleepTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_times do |t|
      t.timestamp :sleep_ts

      t.timestamps
    end
  end
end
