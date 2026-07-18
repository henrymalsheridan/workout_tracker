class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.order(name: :asc)
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      redirect_to exercises_path
    else
      render :new, status: :unprocessable_entity
  end
end

private

def exercise_params
    params.require(:exercise).permit(:name)
  end
end
