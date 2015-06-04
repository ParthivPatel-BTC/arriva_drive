class CohortActivity < ActiveRecord::Base
	belongs_to :cohort
	belongs_to :activity
end
