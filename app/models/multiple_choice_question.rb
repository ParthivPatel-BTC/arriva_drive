class MultipleChoiceQuestion < ActiveRecord::Base
	belongs_to :activity
	has_many :answers
end
