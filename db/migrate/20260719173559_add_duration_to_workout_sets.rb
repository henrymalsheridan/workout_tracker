class AddDurationToWorkoutSets < ActiveRecord::Migration[8.1]
  def change
    add_column :workout_sets, :duration, :integer
  end
end
