class Workout < ApplicationRecord
  #Associtations 
  belongs_to :workout_type

  has_many :exercise_logs, dependent: :destroy
  has_many :exercises, through: :exercise_logs
  
  #allows workout form to save exercise logs directly
  accepts_nested_attributes_for :exercise_logs, reject_if: :all_blank, allow_destroy: true

  #Connects to active storage
  has_many_attached :media

  validates :date, presence: true
end
