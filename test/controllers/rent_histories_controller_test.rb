require "test_helper"

class RentHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rent_histories_index_url
    assert_response :success
  end

  test "should get new" do
    get rent_histories_new_url
    assert_response :success
  end
end
