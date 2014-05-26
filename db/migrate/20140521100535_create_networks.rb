class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.integer :current_participant_id
      t.integer :participant_id

      t.timestamps
    end
  end
end
