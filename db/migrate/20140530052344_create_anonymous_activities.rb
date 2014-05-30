class CreateAnonymousActivities < ActiveRecord::Migration
  def change
    create_table :anonymous_activities do |t|
      t.references :note, index: true
      t.references :behaviour, index: true

      t.timestamps
    end
  end
end
