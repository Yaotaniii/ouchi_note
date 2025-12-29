require "test_helper"

class BicycleRegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bicycle_registrations_index_url
    assert_response :success
  end

  test "should get new" do
    get bicycle_registrations_new_url
    assert_response :success
  end

  test "should get edit" do
    get bicycle_registrations_edit_url
    assert_response :success
  end
end
