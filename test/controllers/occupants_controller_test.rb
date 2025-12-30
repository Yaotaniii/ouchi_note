require "test_helper"

class OccupantsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get occupants_new_url
    assert_response :success
  end

  test "should get create" do
    get occupants_create_url
    assert_response :success
  end

  test "should get destroy" do
    get occupants_destroy_url
    assert_response :success
  end
end
