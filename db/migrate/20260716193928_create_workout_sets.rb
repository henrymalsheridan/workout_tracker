class CreateWorkoutSets < ActiveRecord::Migration[8.1]
  def change
    create_table :workout_sets do |t|
      t.integer :set_number
      t.integer :reps
      t.decimal :weight
      t.references :exercise_log, null: false, foreign_key: true

      t.timestamps
    end
  end
end
