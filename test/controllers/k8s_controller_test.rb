require "test_helper"

class K8sControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get k8s_index_url
    assert_response :success
  end
end
