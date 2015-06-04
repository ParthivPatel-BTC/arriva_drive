class Cohort < ActiveRecord::Base
	has_many :cohort_events, dependent: :destroy
	has_many :cohort_activities, dependent: :destroy
	has_many :participants, dependent: :nullify
	has_many :events, through: :cohort_events
	has_many :activities, through: :cohort_activities
	validates_presence_of :name, :year_started, :cohort_type
	COHORT_TYPE = [['DRIVE', '1'], ['Graduate', '2']]
  scope :drive, -> { where(cohort_type: 1) }
  scope :graduate, -> { where(cohort_type: 2) }
end
