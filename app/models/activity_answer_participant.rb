class ActivityAnswerParticipant < ActiveRecord::Base
  belongs_to :activity
  belongs_to :answer
  belongs_to :participant

  after_create :update_participant_score

  scope :filter, ->(attrs_map) { where(attrs_map) }
  scope :filter_by_activity_participant, ->(activity, participant) { filter(activity_id: activity, participant_id: participant) }

  def is_correct?
    answer.correct
  end

  private

  def update_participant_score
    if is_correct?
      participant.increase_score(activity, Settings.activity_points.correct_mcq_answer)
    end
  end
end
