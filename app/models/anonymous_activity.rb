class AnonymousActivity < ActiveRecord::Base
  belongs_to :note
  belongs_to :behaviour
  has_many :scores, as: :scorable
end
