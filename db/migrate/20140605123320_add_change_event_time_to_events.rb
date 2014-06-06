class AddChangeEventTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_end_time, :time
  end
end
