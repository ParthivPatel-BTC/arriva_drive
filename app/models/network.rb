class Network < ActiveRecord::Base
  belongs_to :participant
  belongs_to :current_participant, class_name: 'Participant', foreign_key: 'current_participant_id'

  scope :participants_in_network, ->(participant) { where("networks.current_participant_id = ? OR networks.participant_id = ?", participant, participant).uniq }
end
