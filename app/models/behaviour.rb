class Behaviour < ActiveRecord::Base
	has_many :activities
	has_and_belongs_to_many :events
  has_many :scores, as: :scorable
  has_many :tags, as: :taggable
  has_many :behaviours_events
  has_many :events, through: :behaviours_events
  has_and_belongs_to_many :values

  def total_activities_score(participant=nil)
    score = if participant.present?
      Score.by_activity(activities.pluck(:id)).where(participant_id: participant.id).sum(:score)
    else
      Score.by_activity(activities.pluck(:id)).sum(:score)
    end
    score || 0
  end

  def total_activities_levels(participant)
    total_score = total_activities_score(participant)
    find_level(total_score)
  end

  def find_level(score)
    if (0..110).include?(score)
      1
    elsif (111..1999).include?(score)
      2
    elsif (2000..2999).include?(score)
      3
    elsif (3000..3999).include?(score)
      4
    elsif score > 3999
      5
    end
  end

  def completed_activities
    activities.inject(0) { |count, activity| count + activity.completed_count }
  end
end
