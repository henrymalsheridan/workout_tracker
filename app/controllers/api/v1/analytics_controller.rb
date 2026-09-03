class Api::V1::AnalyticsController < ApplicationController
  # 1. THE SECURITY FIX: Bypass Devise for this specific endpoint so Postman (and Chart.js) can read the JSON
  skip_before_action :authenticate_user!

  def progress
    # get exercise_id from JavaScript fetch request
    exercise_id = params[:exercise_id]

    # Return an error if no exercise was selected
    if exercise_id.blank?
      render json: { error: "Exercise ID is required" }, status: :bad_request
      return
    end

    # 2. THE SORTING FIX: We add .order() to force the SQL database to return chronological data
    chart_data = WorkoutSet
      .joins(exercise_log: :workout)
      .where(exercise_logs: { exercise_id: exercise_id })
      .group('DATE(workouts.date)')
      .order('DATE(workouts.date) ASC') # <--- THIS SORTS THE DATES!
      .maximum(:weight)

    # chart_data looks like: { "2026-07-10" => 85.0, "2026-07-15" => 90.0 }
    
    # Split hash into two arrays and render as JSON
    # Serialization
    render json: {
      # Grab the Date objects and format them
      labels: chart_data.keys.map { |date| date.to_date.strftime("%b %d, %Y") },
      
      # Grab the actual weight numbers
      data: chart_data.values 
    }
  end
end