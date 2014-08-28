class AddNetworkNotificationToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :network_notification, :boolean, default: true
  end
end
