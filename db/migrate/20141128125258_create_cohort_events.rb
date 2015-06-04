class CreateCohortEvents < ActiveRecord::Migration
  def change
    create_table :cohort_events do |t|
      t.integer :cohort_id
      t.integer :event_id

      t.timestamps
    end
  end
end
