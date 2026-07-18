class CreateExerciseLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :exercise_logs do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true

      t.timestamps
    end
  end
end
