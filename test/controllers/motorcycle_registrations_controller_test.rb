require "test_helper"

class MotorcycleRegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get motorcycle_registrations_index_url
    assert_response :success
  end

  test "should get new" do
    get motorcycle_registrations_new_url
    assert_response :success
  end

  test "should get edit" do
    get motorcycle_registrations_edit_url
    assert_response :success
  end
end
