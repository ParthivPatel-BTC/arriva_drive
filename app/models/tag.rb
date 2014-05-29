class Tag < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true
  belongs_to :note

  scope :behaviour_tags, -> { where(taggable_type: 'Behaviour') }
  scope :participants_tags, -> { where(taggable_type: 'Participant') }
end
