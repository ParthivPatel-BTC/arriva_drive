class AddFileDisplayNameToEventFiles < ActiveRecord::Migration
  def change
  	add_column :event_files, :display_name, :string
  end
end
