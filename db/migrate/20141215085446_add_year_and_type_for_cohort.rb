class AddYearAndTypeForCohort < ActiveRecord::Migration
  def change
  	add_column :cohorts, :year_started, :integer
  	add_column :cohorts, :cohort_type, :integer
  end
end
