class Answer < ActiveRecord::Base
	belongs_to :multiple_choice_question
  has_many :activity_answer_participants

  scope :correct, -> { where(correct: true) }
end
