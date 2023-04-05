class CreateWakeUpTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :wake_up_times do |t|
      t.timestamp :wake_up_ts

      t.timestamps
    end
  end
end
