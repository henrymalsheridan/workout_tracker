class Api::V1::AnalyticsController < ApplicationController
  def progress
    #get  exercise_id from JavaScript fetch request
    exercise_id = params[:exercise_id]

    # Return an error if no exercise was selected
    if exercise_id.blank?
      render json: { error: "Exercise ID is required" }, status: :bad_request
      return
    end

    #run database query using date column
    chart_data = WorkoutSet
      .joins(exercise_log: :workout)
      .where(exercise_logs: { exercise_id: exercise_id })
      .group('DATE(workouts.date)')
      .maximum(:weight)

    # chart_data looks like: { "2026-07-10" => 85.0, "2026-07-15" => 90.0 }
    
    # Split hash into two arrays and render as JSON
    #Serilization
    render json: {
      #Grab the Date objects and format them
      labels: chart_data.keys.map { |date| date.to_date.strftime("%b %d, %Y") },
      
      #Grab the actual weight numbers
      data: chart_data.values 
    }
  end
end