class Note < ActiveRecord::Base
  belongs_to :owner, class_name: 'Participant', foreign_key: 'owner_id'
end
