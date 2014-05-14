class Activity < ActiveRecord::Base
	belongs_to :behaviour
	has_one :multiple_choice_question

  accepts_nested_attributes_for :multiple_choice_question, allow_destroy: true

	ACTIVITY_TYPE = [['Book', '1'], ['Video', '2'], ['App', '3'], ['Magazine', '4']]

  validates_presence_of :title
end
