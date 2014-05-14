class Event < ActiveRecord::Base
  has_many :behaviours_events
  has_many :behaviours, through: :behaviours_events
  accepts_nested_attributes_for :behaviours_events, allow_destroy: true

	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
