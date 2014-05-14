class BehavioursEvent < ActiveRecord::Base
  belongs_to :behaviour
  belongs_to :event
end
