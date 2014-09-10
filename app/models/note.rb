class Note < ActiveRecord::Base
  belongs_to :owner, class_name: 'Participant', foreign_key: 'owner_id'
  has_many :tags, dependent: :destroy
  has_many :anonymous_activities, dependent: :destroy
  accepts_nested_attributes_for :tags

  after_create :update_participant_score

  def behaviour_tags
    tags.behaviour_tags
  end

  def send_notification_to_participant(tagged_participant, current_participant)
    begin
      ArriveDriveMailer.delay.send_notification_to_participant(self, tagged_participant, current_participant)
    rescue Exception => e
      Rails.logger.error "Failed to send email, email address: #{tagged_participant.email}"
      Rails.logger.error "#{e.backtrace.first}: #{e.message} (#{e.class})"
    end
  end

  private

  def update_participant_score
    behaviour_tags.each do |behaviour_tag|
      behaviour = behaviour_tag.taggable
      anonymous_activity = anonymous_activities.create(behaviour_id: behaviour.id)
      owner.increase_score(anonymous_activity, Settings.activity_points.write_note, :anonymous_activity)
    end
  end
end
