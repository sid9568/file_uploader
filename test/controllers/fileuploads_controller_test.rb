require "test_helper"

class FileuploadsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fileuploads_index_url
    assert_response :success
  end
end
