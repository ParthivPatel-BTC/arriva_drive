class Participant < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :scores
  has_many :networks, foreign_key: 'current_participant_id'
  has_many :notes, foreign_key: 'owner_id'

  paperclip_options = {
      styles: {
          medium: "#{Settings.paperclip.style.medium}>",
          thumb: "#{Settings.paperclip.style.thumb}>"
      },
      :url => Settings.paperclip.image_path
  }

  accepts_nested_attributes_for :scores, allow_destroy: true, :reject_if => proc {|attrs| attrs['score'].blank? }
  has_attached_file :photo, Paperclip::Attachment.default_options.merge(paperclip_options)
  validates_attachment_content_type :photo, content_type:  /\Aimage\/.*\Z/

  validates_presence_of :first_name, :last_name, :job_title, :year_started

  # For filter with alpha character in my network
  scope :participant_by_alpha_search, -> (alpha_character) { where("first_name ILIKE ?", "#{alpha_character}%")}

  # For all participants listing
  scope :all_participants, -> (current_participant_id) { where('id != ?', current_participant_id).order(:first_name) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def behaviour_score_level(behaviour_id)
    score = scores.where(behaviour_id: behaviour_id, participant_id: id).first
    if (0..110).include?(score)
      1
    elsif (111..1999).include?(score)
      2
    elsif (2000..2999).include?(score)
      3
    elsif (3000..3999).include?(score)
      4
    elsif (4000..5000).include?(score)
      5
    else
      0
    end
  end

  def deactivate!
    update_attribute(:active, false)
  end

  def activate!
    update_attribute(:active, true)
  end

  def send_invitation_to_participant
    begin
      ArriveDriveMailer.send_invitation_to_participant(self).deliver
    rescue Exception => e
      Rails.logger.error "Failed to send email, email address: #{self.email}"
      Rails.logger.error "#{e.backtrace.first}: #{e.message} (#{e.class})"
    end
  end
end
