class AddOnlineCourseImageToActivity < ActiveRecord::Migration
  def change
    add_attachment :activities, :online_course_image
  end
end
