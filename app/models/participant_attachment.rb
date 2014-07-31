class ParticipantAttachment < ActiveRecord::Base
  belongs_to :participant
  has_many :shared_attachments
  validates_presence_of :attachment

  has_attached_file :attachment, Paperclip::Attachment.default_options.merge(Settings.participant_attachments.paperclip)
  validates_attachment_content_type :attachment, :content_type => /.*/

  scope :attachments, -> (participant_id) { where(participant_id: participant_id) }
end
