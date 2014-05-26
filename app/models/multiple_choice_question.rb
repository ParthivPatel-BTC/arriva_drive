class MultipleChoiceQuestion < ActiveRecord::Base
	belongs_to :activity
	has_many :answers

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :set_blank_answers_to_false

  def correct_answer
    answers.correct.first
  end

  private

  def set_blank_answers_to_false(attrs)
    attrs['correct'] = false if attrs['correct'].blank?
    false
  end
end
