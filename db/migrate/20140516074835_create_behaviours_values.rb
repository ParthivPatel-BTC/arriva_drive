class CreateBehavioursValues < ActiveRecord::Migration
  def change
    create_table :behaviours_values do |t|
      t.integer :behaviour_id
      t.integer :value_id
    end
  end
end
