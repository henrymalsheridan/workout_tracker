require "test_helper"

class WorkoutTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get workout_types_index_url
    assert_response :success
  end

  test "should get new" do
    get workout_types_new_url
    assert_response :success
  end
end
