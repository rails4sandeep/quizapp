class CreateQuestionsets < ActiveRecord::Migration
  def change
    create_table :questionsets do |t|
      t.text :question
      t.text :answer1
      t.text :answer2
      t.text :answer3
      t.text :answer4
      t.integer :correct
      t.integer :weight

      t.timestamps
    end
  end
end
