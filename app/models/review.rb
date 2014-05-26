class Review < ActiveRecord::Base
  belongs_to :participant
  belongs_to :activity
end
