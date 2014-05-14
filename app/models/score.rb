class Score < ActiveRecord::Base
	belongs_to :participant
	belongs_to :behaviour
end
