class Network < ActiveRecord::Base
  belongs_to :participant
  belongs_to :current_participant, class_name: 'Participant', foreign_key: 'current_participant_id'

  scope :participants_in_network, ->(participant) { where("networks.current_participant_id = ? OR networks.participant_id = ?", participant, participant).uniq }

  class << self
    def all_participants_in_network(participant)
      participant_ids_arr = participants_in_network(participant).pluck(:current_participant_id, :participant_id).flatten.uniq - [participant.id]
      Participant.where(id: participant_ids_arr)
    end
  end
end
