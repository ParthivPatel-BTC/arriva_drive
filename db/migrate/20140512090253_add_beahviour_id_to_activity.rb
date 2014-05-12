class AddBeahviourIdToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :behaviour_id, :integer
  end
end
