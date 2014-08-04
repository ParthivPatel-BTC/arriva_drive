class AddAttachmentToParticipantAttachments < ActiveRecord::Migration
  def change
    add_attachment :participant_attachments, :attachment
  end
end
