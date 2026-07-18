class ExerciseLog < ApplicationRecord

  # Associations
  belongs_to :workout
  belongs_to :exercise

  #Granular metrics for specifc exercise
  has_many :workout_sets, dependent: :destroy

  #gets set data passed down from parent workout
  accepts_nested_attributes_for :workout_sets, reject_if: :all_blank, allow_destroy: true
end
