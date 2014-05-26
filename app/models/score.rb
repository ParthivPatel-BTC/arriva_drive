class Score < ActiveRecord::Base
	belongs_to :participant
  belongs_to :scorable, polymorphic: true
	# belongs_to :behaviour

  validate :score, numericality: { only_integer: true }

  scope :activity_scores, -> { where(scorable_type: 'Activity') }
  scope :behaviour_scores, -> { where(scorable_type: 'Behaviour') }
  scope :by_activity, ->(activity) { activity_scores.where(scorable_id: activity) }

  def percentile_score
    score * 20 if score
  end

  def difference_with_top_score
    top_score - score if score
  end

  def percentile_difference_with_top_score
    (top_score - score) * 20 if score
  end

  def top_score
    Score.where(scorable_type: scorable_type).maximum(:score)
  end
end
