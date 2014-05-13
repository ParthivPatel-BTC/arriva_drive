class AddActivityIdToMultipleChoiceQuestion < ActiveRecord::Migration
  def change
    add_column :multiple_choice_questions, :activity_id, :integer
    add_index :multiple_choice_questions, :activity_id
  end
end
