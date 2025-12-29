require "test_helper"

class ParkingSpacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get parking_spaces_index_url
    assert_response :success
  end

  test "should get edit" do
    get parking_spaces_edit_url
    assert_response :success
  end
end
