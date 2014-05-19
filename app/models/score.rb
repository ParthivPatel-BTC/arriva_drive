class Score < ActiveRecord::Base
	belongs_to :participant
	belongs_to :behaviour

  validate :score, numericality: { only_integer: true }

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
    Score.where(behaviour_id: behaviour_id).maximum(:score)
  end
end
