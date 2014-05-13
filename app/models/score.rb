class Score < ActiveRecord::Base
  attr_accessible :behaviour_id, :score
	belongs_to :participant
	belongs_to :behaviour
end
