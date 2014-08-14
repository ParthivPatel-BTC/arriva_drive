class Participant < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :scores
  has_many :networks, foreign_key: 'current_participant_id'
  has_many :notes, foreign_key: 'owner_id'
  has_many :activity_answer_participants
  has_many :reviews
  has_many :tags, as: :taggable
  has_many :participant_attachments
  has_many :shared_attachments, dependent: :destroy

  paperclip_options = {
      styles: {kk
          medium: "#{Settings.paperclip.style.medium}>",
          thumb: "#{Settings.paperclip.style.thumb}>"
      },
      :url => Settings.paperclip.image_path
  }

  accepts_nested_attributes_for :scores, allow_destroy: true, :reject_if => proc {|attrs| attrs['score'].blank? }
  has_attached_file :photo, Paperclip::Attachment.default_options.merge(paperclip_options)
  validates_attachment :photo, content_type: {content_type:  /\Aimage\/.*\Z/}, size: { :in => 0..10.megabytes }

  validates_presence_of :first_name, :last_name, :job_title, :year_started

  # For filter with alpha character in my network
  scope :participant_by_alpha_search, -> (alpha_character) { where("upper(first_name) LIKE upper(?)", "#{alpha_character}%")}

  # For all participants listing
  scope :all_participants, -> (current_participant_id) { where('id != ?', current_participant_id).order(:first_name) }

  after_create :add_unique_password

  def full_name
    "#{first_name} #{last_name}"
  end

  def behaviour_score_level(behaviour_id)
    score = scores.where(scorable_id: behaviour_id, participant_id: id).first
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

  def send_invitation_to_participant(password)
    begin
      ArriveDriveMailer.send_invitation_to_participant(self, password).deliver
    rescue Exception => e
      Rails.logger.error "Failed to send email, email address: #{self.email}"
      Rails.logger.error "#{e.backtrace.first}: #{e.message} (#{e.class})"
    end
  end

  def has_answered_this_activity?(activity)
    ActivityAnswerParticipant.filter_by_activity_participant(activity, self).first.present?
  end

  def activity_answer(activity)
    ActivityAnswerParticipant.filter_by_activity_participant(activity, self).first.try(:answer)
  end

  def answer_of_activity(activity)
    activity_answer_participants.find_by_activity_id(activity.id).answer
  end

  def has_given_correct_answer?(activity)
    participants_answer = activity_answer_participants.find_by_activity_id(activity.id).answer
    correct_answer = activity.correct_answer
    participants_answer == correct_answer
  end

  def has_given_wrong_answer?(activity)
    !has_given_correct_answer?(activity)
  end

  def has_reviewed_this_activity?(activity)
    get_review_of_activity(activity).present?
  end

  def get_review_of_activity(activity)
    reviews.find_by_activity_id(activity.id)
  end

  def get_review_text_of_activity(activity)
    get_review_of_activity(activity).try(:review_text)
  end

  def create_score(scorable)
    scores.create(
      scorable_id: scorable.id,
      scorable_type: scorable.class.to_s,
      score: 0
    )
  end

  def increase_score(activity, points, type=:activity)
    score = if (type == :activity)
        scores.by_activity(activity).first
      else
        scores.by_anonymous_activity(activity).first
        # scores.by_behaviour(activity).first
    end
    score = create_score(activity) if score.blank?
    score.update_attribute(:score, score.score + points)

    # behaviour_score = scores.by_behaviour(activity).first
    # behaviour_score.update_attribute(:score, behaviour_score.score + points) unless behaviour_score.blank?
  end

  def completed_activities(behaviour=nil)
    if behaviour.present?
      activity_answer_participants.where(activity_id: behaviour.activities.pluck(:id))
    else
      activity_answer_participants
    end
  end

  def total_activity_score_for_behaviour(behaviour)
    total_activity_score = behaviour.total_activities_score(self)
    total_activity_score + total_anonymous_activity_score(behaviour)
  end

  def total_anonymous_activity_score(behaviour)
    anonymous_activity_ids = AnonymousActivity.where(behaviour_id: behaviour.id).pluck(:id)
    scores.by_anonymous_activity(anonymous_activity_ids).sum(:score)
  end

  def tag_title
    full_name
  end

  def active_for_authentication?
    super && self.active
  end

  def add_unique_password
    update_attribute(:password, self.class.generate_unique_passowrd)
  end

  def self.generate_unique_passowrd
    participant={}
    participant[:password] = Devise.friendly_token[0,6]
  end
end
