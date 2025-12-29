require "test_helper"

class MaintenanceRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get maintenance_records_index_url
    assert_response :success
  end

  test "should get show" do
    get maintenance_records_show_url
    assert_response :success
  end

  test "should get new" do
    get maintenance_records_new_url
    assert_response :success
  end

  test "should get edit" do
    get maintenance_records_edit_url
    assert_response :success
  end
end
