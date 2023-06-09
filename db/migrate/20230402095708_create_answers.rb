class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.text :body
      t.belongs_to :question, null: false, foreign_keys: true
      t.timestamps
    end
  end
end
