class Score < ActiveRecord::Base
	belongs_to :participant
	belongs_to :behaviour

  validate :score, numericality: { only_integer: true }
end
