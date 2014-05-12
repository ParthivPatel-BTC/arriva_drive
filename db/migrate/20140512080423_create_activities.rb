class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.string :link
      t.integer :type
      t.text :description

      t.timestamps
    end
  end
end
