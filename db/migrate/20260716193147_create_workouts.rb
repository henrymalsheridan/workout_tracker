class CreateWorkouts < ActiveRecord::Migration[8.1]
  def change
    create_table :workouts do |t|
      t.datetime :date
      t.text :notes
      t.references :workout_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
