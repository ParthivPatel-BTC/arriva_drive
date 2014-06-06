class FixEventTime < ActiveRecord::Migration
  def change
    rename_column :events, :event_time, :event_start_time
    change_column :events, :event_start_time, :time
  end

  def down
    rename_column :events, :event_start_time, :event_time
    change_column :events, :event_start_time, :time
  end
end
