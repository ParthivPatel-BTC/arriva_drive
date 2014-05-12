class Activity < ActiveRecord::Base
	belongs_to :behaviour
	has_one :multiple_choice_question

	ACTIVITY_TYPE = [['Book', '1'], ['Video', '2'], ['App', '3'], ['Magazine', '4']]
end
