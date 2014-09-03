class ChangeNotificationsDefaultToFalse < ActiveRecord::Migration
  def change
  	change_column :participants, :network_notification, :boolean, default: false
  	change_column :participants, :files_notification, :boolean, default: false
  	change_column :participants, :notes_notification, :boolean, default: false
  end
end
