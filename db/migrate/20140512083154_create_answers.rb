class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer_text
      t.boolean :correct

      t.timestamps
    end
  end
end
