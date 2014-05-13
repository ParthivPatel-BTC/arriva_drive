class AddMultipleChoiceQuestionIdToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :multiple_choice_question_id, :integer
    add_index :answers, :multiple_choice_question_id
  end
end
