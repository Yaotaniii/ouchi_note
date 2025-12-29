require "test_helper"

class RoomPhotosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get room_photos_index_url
    assert_response :success
  end

  test "should get new" do
    get room_photos_new_url
    assert_response :success
  end
end
