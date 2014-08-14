class AddFileTitleToParticipantAttachments < ActiveRecord::Migration
  def change
    add_column :participant_attachments, :file_title, :string
  end
end
