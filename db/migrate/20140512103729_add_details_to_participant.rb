class AddDetailsToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :first_name, :string
    add_column :participants, :last_name, :string
    add_column :participants, :job_title, :string
    add_column :participants, :division, :integer
    add_column :participants, :year_started, :integer
    add_column :participants, :performance_summary, :string
  end
end
