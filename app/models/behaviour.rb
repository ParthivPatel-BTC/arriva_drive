class Behaviour < ActiveRecord::Base
	has_many :activities
	has_and_belongs_to_many :behaviours
	has_many :scores
end
