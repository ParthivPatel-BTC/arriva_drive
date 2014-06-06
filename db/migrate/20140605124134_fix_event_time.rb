class FixEventTime < ActiveRecord::Migration
  def change
    rename_column :events, :event_time, :event_start_time
  end

  def down
    rename_column :events, :event_start_time, :event_time
  end
end
