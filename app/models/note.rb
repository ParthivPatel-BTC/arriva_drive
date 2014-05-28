class Note < ActiveRecord::Base
  belongs_to :owner, class_name: 'Participant', foreign_key: 'owner_id'
  has_many :tags
  accepts_nested_attributes_for :tags

  # after_create :update_participant_score

  private

  # def update_participant_score
  #   participant.increase_score(activity, Settings.activity_points.review_completion)
  # end
end
