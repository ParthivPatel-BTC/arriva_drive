class AddActiveToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :active, :boolean, default: true
  end
end
