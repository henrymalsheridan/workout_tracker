class WorkoutsController < ApplicationController

  #finds workout in database beofre running these actions
  before_action :set_workout, only: [:show, :edit, :update, :destroy]

  # blocks non admin from writing data
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  
  # GET/ workouts
  def index
    #gets all workouts and sorts by date
    @workouts = Workout.all.order(date: :desc)
  end

  def show
  end


  def new
    #blank workout object to hand to html form
    @workout = Workout.new

    exercise_log = @workout.exercise_logs.build

    exercise_log.workout_sets.build(set_number: 1)
    exercise_log.workout_sets.build(set_number: 2)

end

def create
  #blank workout object to pass to the form
  @workout = Workout.new(workout_params)
  
  if @workout.save
      #if succesful redirect to homepage
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
      #if it fails re-render form
  end
end

def edit
end

def update
  if @workout.update(workout_params)
      redirect_to root_path, notice: "Workout successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
end

def destroy
  @workout.destroy
  redirect_to root_path, notice: "Workout deleted."
end



private
#private helper mehtods

def set_workout
  @workout = Workout.find(params[:id])
end

def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

#strong parameters secrutiy to only allow data entry for our database fields
  def workout_params
    params.require(:workout).permit(
      :date,
      :notes, 
      :workout_type_id,
      media:[],
      exercise_logs_attributes: [
        :id,
        :exercise_id,
        :_destroy,
        workout_sets_attributes: [:id, :set_number, :reps, :weight, :_destroy]
      ])
  end
end
