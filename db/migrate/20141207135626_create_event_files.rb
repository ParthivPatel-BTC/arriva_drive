class CreateEventFiles < ActiveRecord::Migration
  def change
    create_table :event_files do |t|
      t.integer :event_id
      t.string :event_doc_file_name
      t.string :event_doc_content_type
      t.integer :event_doc_file_size

      t.timestamps
    end
  end
end
