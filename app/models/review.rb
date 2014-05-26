class Review < ActiveRecord::Base
  belongs_to :participant
  belongs_to :activity

  after_create :update_participant_score

  private

  def update_participant_score
    participant.increase_score(activity, Settings.activity_points.review_completion)
  end
end
