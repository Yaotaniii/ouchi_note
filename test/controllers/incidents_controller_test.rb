require "test_helper"

class IncidentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get incidents_index_url
    assert_response :success
  end

  test "should get show" do
    get incidents_show_url
    assert_response :success
  end

  test "should get new" do
    get incidents_new_url
    assert_response :success
  end

  test "should get edit" do
    get incidents_edit_url
    assert_response :success
  end
end
