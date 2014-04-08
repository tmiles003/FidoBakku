require 'test_helper'

class Api::EvaluationSessionsControllerTest < ActionController::TestCase
  setup do
    @api_evaluation_session = api_evaluation_sessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_evaluation_sessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_evaluation_session" do
    assert_difference('Api::EvaluationSession.count') do
      post :create, api_evaluation_session: {  }
    end

    assert_redirected_to api_evaluation_session_path(assigns(:api_evaluation_session))
  end

  test "should show api_evaluation_session" do
    get :show, id: @api_evaluation_session
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_evaluation_session
    assert_response :success
  end

  test "should update api_evaluation_session" do
    patch :update, id: @api_evaluation_session, api_evaluation_session: {  }
    assert_redirected_to api_evaluation_session_path(assigns(:api_evaluation_session))
  end

  test "should destroy api_evaluation_session" do
    assert_difference('Api::EvaluationSession.count', -1) do
      delete :destroy, id: @api_evaluation_session
    end

    assert_redirected_to api_evaluation_sessions_path
  end
end
