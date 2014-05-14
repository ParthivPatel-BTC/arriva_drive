class MultipleChoiceQuestion < ActiveRecord::Base
	belongs_to :activity
	has_many :answers

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :set_nil_answers_false

  private

  def set_nil_answers_false(attrs)
    attrs['correct'] = false if attrs['correct'].blank?
    false
  end
end
