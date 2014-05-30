class Note < ActiveRecord::Base
  belongs_to :owner, class_name: 'Participant', foreign_key: 'owner_id'
  has_many :tags, dependent: :destroy
  has_many :anonymous_activities, dependent: :destroy
  accepts_nested_attributes_for :tags

  after_create :update_participant_score

  def behaviour_tags
    tags.behaviour_tags
  end

  private

  def update_participant_score
    behaviour_tags.each do |behaviour_tag|
      behaviour = behaviour_tag.taggable
      anonymous_activity = anonymous_activities.create(behaviour_id: behaviour.id)
      owner.increase_score(anonymous_activity, Settings.activity_points.write_note, :anonymous_activity)
    end
  end
end
