class Event < ActiveRecord::Base
  has_many :behaviours_events
  has_many :behaviours, through: :behaviours_events
  accepts_nested_attributes_for :behaviours_events, allow_destroy: true

	# has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  # validates_attachment :image, presence: true, content_type: {content_type: /\Aimage\/.*\Z/}
  validates_presence_of :title, :location, :event_date, :link, :description

  scope :get_monthly_events, -> (month) { where('extract(month from event_date) = ?', Date::MONTHNAMES.index(month)) }

  def event_date_formatted
    event_date.strftime('%d/%m/%Y') rescue nil
  end

  def is_completed?
    Date.today > event_date
  end

  def to_ics
    event = Icalendar::Event.new
    event.dtstart = self.event_date.strftime("%Y%m%dT%H%M%S")
    event.dtend   = DateTime.new(event_date.year, event_date.month, event_date.day, Settings.defaults.i_cal_event_finish_time, 0, 0, 0).strftime("%Y%m%dT%H%M%S")
    event.summary = self.title
    event.description = self.description
    event.location = location
    event.ip_class = "PUBLIC"
    event.created = self.created_at
    event.last_modified = self.updated_at
    event.uid = event.url = "http://localhost:3000/events/#{self.id}"
    event
  end
end
