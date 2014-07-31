class SharedAttachment < ActiveRecord::Base
  belongs_to :participant
  belongs_to :participant_attachment
end
