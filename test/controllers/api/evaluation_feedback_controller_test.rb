require 'test_helper'

class Api::EvaluationFeedbackControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get form" do
    get :form
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
