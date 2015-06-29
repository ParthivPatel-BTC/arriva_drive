class Event < ActiveRecord::Base
  has_many :behaviours_events
  has_many :behaviours, through: :behaviours_events
  has_many :cohort_events
  has_many :cohorts, through: :cohort_events
  has_many :event_files
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :listing => '208x129!', :detail => '492x120!' }, :default_url => "/images/:style/missing.png"
  accepts_nested_attributes_for :behaviours_events, allow_destroy: true
  accepts_nested_attributes_for :event_files, allow_destroy: true
  accepts_nested_attributes_for :cohort_events, allow_destroy: true
  validates_attachment :image, presence: true, content_type: {content_type: /\Aimage\/.*\Z/}, size: { :in => 0..10.megabytes }
  validates_presence_of :title, :location, :event_date, :link, :description

  scope :events_by_month, -> (month) { where('extract(month from event_date) = ?', month).order('event_date DESC, event_start_time DESC') }
  
  scope :search_events_by_month_year, -> (month, year) { where('extract(month from event_date) = ? AND extract(year from event_date) = ?', Date::MONTHNAMES.index(month), year).order('event_date DESC, event_start_time DESC') }

  scope :active, -> { where('event_date >= ?', Date.today).order('event_date, event_start_time') }
  scope :complete, -> { where('event_date < ? ', Date.today).order('event_date desc, event_start_time desc') }

  def event_date_formatted
    event_date.strftime('%d/%m/%Y') rescue nil
  end

  def is_completed?
    Date.today > event_date
  end

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = DateTime.new(event_date.year, event_date.month, event_date.day, get_time_element(:hour, event_start_time),get_time_element(:minute, event_start_time), 0, 0).strftime("%Y%m%dT%H%M%S")
    event.dtend   = DateTime.new(event_date.year, event_date.month, event_date.day, get_time_element(:hour, event_end_time), get_time_element(:minute, event_end_time), 0, 0).strftime("%Y%m%dT%H%M%S")
    event.summary = self.title
    event.description = self.description
    event.location = location
    event.ip_class = "PUBLIC"
    event.created = self.created_at
    event.last_modified = self.updated_at
    event.uid = event.url = self.link
    event
  end

  def notify_cohorts
    event_files = self.event_files
    self.cohorts.each do |cohort|
      unless cohort.participants.blank?
        cohort.participants.each do |participant|
          begin
            ArriveDriveMailer.delay.send_notification_for_event(participant, self)
          rescue Exception => e
            Rails.logger.error "Failed to send email, email address: #{participant.email}"
            Rails.logger.error "#{e.backtrace.first}: #{e.message} (#{e.class})"
          end
        end
      end
    end
  end
  
  private

  def get_time_element(element_type, time)
    element_str = element_type == :minute ? '%M' : '%H'
    time.strftime(element_str).to_i || 0
  end
end
