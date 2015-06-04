class AddCohortIdToParticipants < ActiveRecord::Migration
  def change
  	add_column :participants, :cohort_id, :integer  
  end
end
