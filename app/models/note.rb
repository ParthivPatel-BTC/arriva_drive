class Note < ActiveRecord::Base
  belongs_to :owner, class_name: 'Participant', foreign_key: 'owner_id'
  has_many :tags
  accepts_nested_attributes_for :tags
end
