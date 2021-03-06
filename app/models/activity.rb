class Activity < ActiveRecord::Base
  belongs_to :behaviour
  has_one :multiple_choice_question
  has_one :review
  has_many :activity_answer_participants
  has_many :scores, as: :scorable
  has_many :participant_online_course_activities
  has_attached_file :online_course_image, :styles => { :thumb => "75*75!>" }, :default_url => "/images/:style/missing.png"

  validates_attachment :online_course_image, content_type: {content_type: /\Aimage\/.*\Z/}, size: { :in => 0..20.megabytes }

  accepts_nested_attributes_for :multiple_choice_question, allow_destroy: true

  ACTIVITY_TYPE = [['Book', '1'], ['Video', '2'], ['App', '3'], ['Magazine', '4'], ['Online Course', '5']]

  scope :completed, -> { where(complete: true) }

  validates_presence_of :title, :link, :activity_type

  scope :find_activities_by_behaviour_id, -> (behaviour_id) { joins(:behaviour).where("activities.behaviour_id in (?)", behaviour_id)}

  # For filter activities by multiple checkboxes from the left bar
  # And pagination will also change according to checked checkboxes
  def self.get_activities(params)
    if params[:page] && !params[:behaviour_id].present?
      get_activities_for_pagination(params)
    elsif params[:behaviour_id]
      get_activities_by_behaviour_ids(params)
    elsif params[:behaviour_id] && params[:page]
      get_activities_by_behaviour_ids(params)
    else
      get_activities_for_pagination(params)
    end
  end

  def behaviour_name
    behaviour.try(:title)
  end

  def correct_answer
    multiple_choice_question.try(:correct_answer)
  end

  def total_score_of_participant(participant)
    scores.find_by_participant_id(participant.id).try(:score) || 0
  end

  def completed_count
    activity_answer_participants.count
  end

  def activity_type_verbos
    activities_type_str = ''
    ACTIVITY_TYPE.each { |arr| activities_type_str = arr[0] if (arr[1] == activity_type.to_s) }
    activities_type_str.downcase
  end

  private

  def self.split_params_for_filter(params)
    params.split(',')
  end

  def self.get_activities_for_pagination(params)
    Activity.page(params[:page]).per(Settings.participants.pagination.per_page).order('created_at DESC')
  end

  def self.get_activities_by_behaviour_ids(params)
    Activity.find_activities_by_behaviour_id(split_params_for_filter(params[:behaviour_id])).page(params[:page]).per(Settings.participants.pagination.per_page)
  end
end
