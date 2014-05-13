class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :participant_id
      t.integer :behaviour_id
      t.integer :score

      t.timestamps
    end
  end
end
