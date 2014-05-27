class Behaviour < ActiveRecord::Base
	has_many :activities
	has_and_belongs_to_many :events
  has_many :scores, as: :scorable
  has_many :behaviours_events
  has_many :events, through: :behaviours_events
  has_and_belongs_to_many :values
end
