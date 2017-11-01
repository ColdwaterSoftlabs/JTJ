require 'test_helper'

class JtjControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get jtj_index_url
    assert_response :success
  end

end
