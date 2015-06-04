class CreateCohortActivities < ActiveRecord::Migration
  def change
    create_table :cohort_activities do |t|
      t.integer :cohort_id
      t.integer :activity_id

      t.timestamps
    end
  end
end
