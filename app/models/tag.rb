class Tag < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true
  belongs_to :note

  scope :behaviour_tags, -> { where(taggable_type: 'Behaviour') }
  scope :participants_tags, -> { where(taggable_type: 'Participant') }
  scope :by_participant, ->(participant) { participants_tags.where(taggable_id: participant) }
end
