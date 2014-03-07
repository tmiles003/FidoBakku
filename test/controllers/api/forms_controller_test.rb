require 'test_helper'

class Api::FormsControllerTest < ActionController::TestCase
  setup do
    @api_form = api_forms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_forms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_form" do
    assert_difference('Api::Form.count') do
      post :create, api_form: { account_id: @api_form.account_id, name: @api_form.name }
    end

    assert_redirected_to api_form_path(assigns(:api_form))
  end

  test "should show api_form" do
    get :show, id: @api_form
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_form
    assert_response :success
  end

  test "should update api_form" do
    patch :update, id: @api_form, api_form: { account_id: @api_form.account_id, name: @api_form.name }
    assert_redirected_to api_form_path(assigns(:api_form))
  end

  test "should destroy api_form" do
    assert_difference('Api::Form.count', -1) do
      delete :destroy, id: @api_form
    end

    assert_redirected_to api_forms_path
  end
end
