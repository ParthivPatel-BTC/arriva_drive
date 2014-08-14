class AddFilesNotificationToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :files_notification, :boolean, default: true
  end
end
