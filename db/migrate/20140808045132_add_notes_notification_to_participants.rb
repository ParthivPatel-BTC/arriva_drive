class AddNotesNotificationToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :notes_notification, :boolean, default: true
  end
end
