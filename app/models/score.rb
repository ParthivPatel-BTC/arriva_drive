class Score < ActiveRecord::Base
	belongs_to :participant
  belongs_to :scorable, polymorphic: true
	# belongs_to :behaviour

  validate :score, numericality: { only_integer: true }

  MAX_SCORE = 5000

  scope :activity_scores, -> { where(scorable_type: 'Activity') }
  scope :behaviour_scores, -> { where(scorable_type: 'Behaviour') }
  scope :anonymous_activity_scores, -> { where(scorable_type: 'AnonymousActivity') }

  scope :by_activity, ->(activity) { activity_scores.where(scorable_id: activity) }
  scope :by_behaviour, ->(behaviour) { behaviour_scores.where(scorable_id: behaviour) }
  scope :by_anonymous_activity, ->(anonymous_activity) { anonymous_activity_scores.where(scorable_id: anonymous_activity) }

  def to_level(score)
    scorable.try(:find_level, score)
  end

  def percentile_score
    # to_level(score) * 20 if score
    100 * score / MAX_SCORE
  end

  def difference_with_top_score
    top_score - score if score
  end

  def percentile_difference_with_top_score
    (top_score - score) * 100 / MAX_SCORE if score
  end

  def top_score
    Score.where(scorable_type: scorable_type, scorable_id: scorable_id).maximum(:score)
  end
end
