require 'test_helper'

class AssignmentConfigsControllerTest < ActionController::TestCase
  setup do
    @assignment_config = assignment_configs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignment_configs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assignment_config" do
    assert_difference('AssignmentConfig.count') do
      post :create, assignment_config: { assignment_id: @assignment_config.assignment_id, input: @assignment_config.input, output: @assignment_config.output }
    end

    assert_redirected_to assignment_config_path(assigns(:assignment_config))
  end

  test "should show assignment_config" do
    get :show, id: @assignment_config
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assignment_config
    assert_response :success
  end

  test "should update assignment_config" do
    patch :update, id: @assignment_config, assignment_config: { assignment_id: @assignment_config.assignment_id, input: @assignment_config.input, output: @assignment_config.output }
    assert_redirected_to assignment_config_path(assigns(:assignment_config))
  end

  test "should destroy assignment_config" do
    assert_difference('AssignmentConfig.count', -1) do
      delete :destroy, id: @assignment_config
    end

    assert_redirected_to assignment_configs_path
  end
end
