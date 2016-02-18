require 'test_helper'

class SearchTaxControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
