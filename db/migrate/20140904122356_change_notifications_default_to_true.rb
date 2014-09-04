class ChangeNotificationsDefaultToTrue < ActiveRecord::Migration
  def change
  	change_column :participants, :network_notification, :boolean, default: true
  	change_column :participants, :files_notification, :boolean, default: true
  	change_column :participants, :notes_notification, :boolean, default: true
  end
end
