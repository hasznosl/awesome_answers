class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body

      #best to generate using the method: rails generate model answer body:text question:references
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
