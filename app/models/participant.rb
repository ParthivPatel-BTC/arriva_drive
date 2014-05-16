class Participant < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :scores
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

  validates_presence_of :first_name, :last_name, :job_title, :year_started, :scores
  validate :must_have_enter_one_score
  # validate :numericality_of_nested_scores

  def must_have_enter_one_score
    errors.add(:scores, 'must have one score') if scores_empty?
  end

  def scores_empty?
    scores.empty?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def level_for(behaviour_id)
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

  def send_participant_invitation
    begin
      ArriveDriveMailer.send_participant_invitation(self).deliver
    rescue Exception => e
      Rails.logger.error "Failed to send email, email address: #{self.email}"
      Rails.logger.error "#{e.backtrace.first}: #{e.message} (#{e.class})"
    end
  end

  private

  def numericality_of_nested_scores
    error_found = false
    scores.each do |score|
      error_found = true unless score.score.kind_of?(Integer)
    end
    errors.add(:scores, I18n.t('participant.msg.error.score_validation')) if error_found
  end
end
