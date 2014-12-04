class AddCompletedToParticipantOnlineCourseActivities < ActiveRecord::Migration
  def change
    add_column :participant_online_course_activities, :completed, :boolean, default: false
  end
end
