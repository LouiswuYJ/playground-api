require "test_helper"

class Api::V1::PlaygroundsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_playgrounds_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_playgrounds_show_url
    assert_response :success
  end

  test "should get search" do
    get api_v1_playgrounds_search_url
    assert_response :success
  end
end
