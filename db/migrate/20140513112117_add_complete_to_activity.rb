class AddCompleteToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :complete, :boolean
  end
end
