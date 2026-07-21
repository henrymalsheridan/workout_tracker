class ProgressController < ApplicationController
  before_action :authenticate_user!
  def index
    @exercises = Exercise.order(:name)
  end
end
