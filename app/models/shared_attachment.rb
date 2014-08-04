class SharedAttachment < ActiveRecord::Base
  belongs_to :participant
  belongs_to :participant_attachment

  scope :shared_attachment_participants, -> (participant_attachment_id) { where(participant_attachment_id: participant_attachment_id) }
  scope :participant, -> (participant_id) { where(participant_id: participant_id) }
end
