require 'test_helper'

class Api::FormSectionsControllerTest < ActionController::TestCase
  setup do
    @api_form_section = api_form_sections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_form_sections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_form_section" do
    assert_difference('Api::FormSection.count') do
      post :create, api_form_section: {  }
    end

    assert_redirected_to api_form_section_path(assigns(:api_form_section))
  end

  test "should show api_form_section" do
    get :show, id: @api_form_section
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_form_section
    assert_response :success
  end

  test "should update api_form_section" do
    patch :update, id: @api_form_section, api_form_section: {  }
    assert_redirected_to api_form_section_path(assigns(:api_form_section))
  end

  test "should destroy api_form_section" do
    assert_difference('Api::FormSection.count', -1) do
      delete :destroy, id: @api_form_section
    end

    assert_redirected_to api_form_sections_path
  end
end
