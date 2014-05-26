class ChangeBehaviourIdToPolymorphic < ActiveRecord::Migration
  def change
    rename_column :scores, :behaviour_id, :scorable_id
    add_column :scores, :scorable_type, :string

    # To ensure, Active Record's knowledge of the table structure is current before manipulating data
    Score.reset_column_information
    Score.update_all(scorable_type: 'Behaviours')
  end
end
