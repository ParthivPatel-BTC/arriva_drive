class CreateParticipantOnlineCourseActivities < ActiveRecord::Migration
  def change
    create_table :participant_online_course_activities do |t|
      t.references :activity, index: true
      t.references :participant, index: true

      t.timestamps
    end
  end
end
