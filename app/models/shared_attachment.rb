class SharedAttachment < ActiveRecord::Base
  belongs_to :participant
  belongs_to :participant_attachment

  attr_accessor :shared_attachments_attributes
  scope :shared_attachment_participants, -> (participant_attachment_id) { where(participant_attachment_id: participant_attachment_id) }
end
