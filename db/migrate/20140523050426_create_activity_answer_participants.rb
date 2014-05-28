class CreateActivityAnswerParticipants < ActiveRecord::Migration
  def change
    create_table :activity_answer_participants do |t|
      t.references :activity, index: true
      t.references :answer, index: true
      t.references :participant, index: true

      t.timestamps
    end
  end
end
