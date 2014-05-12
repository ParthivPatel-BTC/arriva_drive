class CreateBehavioursEvents < ActiveRecord::Migration
  def change
    create_table :behaviours_events do |t|
    	t.belongs_to :behaviour
      t.belongs_to :event
    end
    add_index :behaviours_events, [:behaviour_id, :event_id]
  end
end
