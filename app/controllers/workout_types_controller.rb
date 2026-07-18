class WorkoutTypesController < ApplicationController
  def index
    @workout_types = WorkoutType.order(name: :asc)
  end

  def new
    @workout_type = WorkoutType.new
  end

  def create
    @workout_type = WorkoutType.new(workout_type_params)

    if @workout_type.save
      redirect_to workout_types_path
    else
      render :new, status: :unprocessable_entity
  end
end

private

def workout_type_params
    params.require(:workout_type).permit(:name)
  end
end