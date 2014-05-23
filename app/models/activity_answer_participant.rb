class ActivityAnswerParticipant < ActiveRecord::Base
  belongs_to :activity
  belongs_to :answer
  belongs_to :participant
end
