class Network < ActiveRecord::Base
  belongs_to :participant
  belongs_to :current_participant, class_name: 'Participant', foreign_key: 'current_participant_id'
end
