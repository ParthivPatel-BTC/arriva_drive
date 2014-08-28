class AddFileDescriptionToParticipantAttachments < ActiveRecord::Migration
  def change
    add_column :participant_attachments, :file_description, :text
  end
end
