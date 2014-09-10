class ParticipantAttachment < ActiveRecord::Base
  belongs_to :participant
  has_many :shared_attachments, dependent: :destroy
  has_many :participants, through: :shared_attachments
  validates_presence_of :attachment

  accepts_nested_attributes_for :participants, reject_if: :all_blank, allow_destroy: true

  has_attached_file :attachment, Paperclip::Attachment.default_options.merge(Settings.participant_attachments.paperclip)

  validates_attachment_content_type :attachment, content_type: ['image/jpeg','image/jpg','image/png','application/pdf', 'application/msword','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.wordprocessingml.document']

  validates_attachment_size :attachment, less_than: 2.megabytes
  scope :attachments, -> (participant_id) { where(participant_id: participant_id) }

  def self.send_shared_notification(attachment, participant_id, current_participant)
    participant = Participant.find_by_id(participant_id)
    begin
      ArriveDriveMailer.delay.send_shared_notification(attachment, participant, current_participant)
    rescue Exception => e
      Rails.logger.error "Failed to send email, email address: #{participant.email}"
      Rails.logger.error "#{e.backtrace.first}: #{e.message} (#{e.class})"
    end
  end
end