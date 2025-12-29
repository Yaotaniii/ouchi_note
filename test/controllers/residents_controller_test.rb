require "test_helper"

class ResidentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get residents_index_url
    assert_response :success
  end

  test "should get show" do
    get residents_show_url
    assert_response :success
  end

  test "should get new" do
    get residents_new_url
    assert_response :success
  end

  test "should get edit" do
    get residents_edit_url
    assert_response :success
  end
end
