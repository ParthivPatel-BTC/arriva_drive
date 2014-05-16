class Value < ActiveRecord::Base
	has_and_belongs_to_many :behaviours
end
