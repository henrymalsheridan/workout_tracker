class Exercise < ApplicationRecord
    has_many :exercise_logs
    has_many :workouts, through: :exercise_logs
end
