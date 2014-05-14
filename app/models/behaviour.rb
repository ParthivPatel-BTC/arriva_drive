class Behaviour < ActiveRecord::Base
	has_many :activities
	has_and_belongs_to_many :behaviours
	has_many :scores
  has_many :behaviours_events
  has_many :events, through: :behaviours_events
end
