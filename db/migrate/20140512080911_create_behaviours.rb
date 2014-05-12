class CreateBehaviours < ActiveRecord::Migration
  def change
    create_table :behaviours do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
