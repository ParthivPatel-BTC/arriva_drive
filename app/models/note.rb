class Note < ActiveRecord::Base
  belongs_to :owner, class_name: 'Participant', foreign_key: 'owner_id'
  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :tags

  after_create :update_participant_score

  private

  def update_participant_score
    tags.behaviour_tags.each do |tag|
      owner.increase_score(tag.taggable, Settings.activity_points.write_note, :behaviour)
    end
  end
end
