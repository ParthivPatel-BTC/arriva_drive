class ActivityAnswerParticipant < ActiveRecord::Base
  belongs_to :activity
  belongs_to :answer
  belongs_to :participant

  scope :filter, ->(attrs_map) { where(attrs_map) }
  scope :filter_by_activity_participant, ->(activity, participant) { filter(activity_id: activity, participant_id: participant) }

  def is_correct?
    answer.correct
  end
end
