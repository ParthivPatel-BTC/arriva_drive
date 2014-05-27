class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.references :taggable, polymorphic: true, index: true
      t.references :note, index: true

      t.timestamps
    end
  end
end
