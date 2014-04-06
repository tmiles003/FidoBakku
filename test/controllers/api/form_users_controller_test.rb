require 'test_helper'

class Api::FormUsersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get assign" do
    get :assign
    assert_response :success
  end

  test "should get remove" do
    get :remove
    assert_response :success
  end

end
