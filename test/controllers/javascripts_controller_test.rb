require "test_helper"

class JavascriptsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get javascripts_show_url
    assert_response :success
  end
end
