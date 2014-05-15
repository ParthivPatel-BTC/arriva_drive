class Event < ActiveRecord::Base
  has_many :behaviours_events
  has_many :behaviours, through: :behaviours_events
  accepts_nested_attributes_for :behaviours_events, allow_destroy: true

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  validates_attachment :image, presence: true, content_type: {content_type: /\Aimage\/.*\Z/}
  validates_presence_of :title, :location, :event_date, :link, :description

  def event_date_formatted
    event_date.strftime('%d/%m/%Y') rescue nil
  end
end
