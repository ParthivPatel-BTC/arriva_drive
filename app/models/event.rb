class Event < ActiveRecord::Base
  has_many :behaviours_events
  has_many :behaviours, through: :behaviours_events
  accepts_nested_attributes_for :behaviours_events, allow_destroy: true

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  validates_attachment :image, presence: true, content_type: {content_type: /\Aimage\/.*\Z/}, size: { :in => 0..20.megabytes }
  validates_presence_of :title, :location, :event_date, :link, :description

  scope :get_monthly_events, -> (month) { where('extract(month from event_date) = ?', Date::MONTHNAMES.index(month)) }
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

  private

  def get_time_element(element_type, time)
    element_str = element_type == :minute ? '%M' : '%H'
    time.strftime(element_str).to_i || 0
  end
end
