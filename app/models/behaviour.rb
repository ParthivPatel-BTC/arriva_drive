class Behaviour < ActiveRecord::Base
  attr_accessible :title, :description
	has_many :activities
	has_and_belongs_to_many :events
	has_many :scores
end
