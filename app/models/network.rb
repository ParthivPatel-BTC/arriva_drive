class Network < ActiveRecord::Base
  belongs_to :participant
  belongs_to :current_participant, class_name: 'Participant', foreign_key: 'current_participant_id'

  scope :participants_in_network, ->(participant) { where("networks.current_participant_id = ? OR networks.participant_id = ?", participant, participant).uniq }

  # This scope is for remove participant from network list
  scope :delete_participant, ->(participant_id, current_participant_id) { where("current_participant_id = ? and participant_id = ? ", current_participant_id, participant_id)}

  class << self
    def all_participants_in_network(participant)
      participant_ids_arr = participants_in_network(participant).pluck(:current_participant_id, :participant_id).flatten.uniq - [participant.id]
      Participant.where(id: participant_ids_arr)
    end
  end

  def self.send_network_notification(network_participant, current_participant)
    begin
      ArriveDriveMailer.send_network_notification(network_participant, current_participant).deliver!
    rescue Exception => e
      Rails.logger.error "Failed to send email, email address: #{network_participant.email}"
      Rails.logger.error "#{e.backtrace.first}: #{e.message} (#{e.class})"
    end
  end
end
