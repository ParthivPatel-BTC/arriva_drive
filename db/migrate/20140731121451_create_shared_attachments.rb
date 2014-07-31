class CreateSharedAttachments < ActiveRecord::Migration
  def change
    create_table :shared_attachments do |t|
      t.integer :participant_id
      t.integer :participant_attachment_id

      t.timestamps
    end
  end
end
