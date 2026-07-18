class CreateWorkoutTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :workout_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
