class CreateParticipantAttachments < ActiveRecord::Migration
  def change
    create_table :participant_attachments do |t|
      t.integer :participant_id

      t.timestamps
    end
  end
end
