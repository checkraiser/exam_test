require 'test_helper'

class AssignmentResultsControllerTest < ActionController::TestCase
  setup do
    @assignment_result = assignment_results(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:assignment_results)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create assignment_result" do
    assert_difference('AssignmentResult.count') do
      post :create, assignment_result: { assignment_id: @assignment_result.assignment_id, enrollment_id: @assignment_result.enrollment_id, pass: @assignment_result.pass }
    end

    assert_redirected_to assignment_result_path(assigns(:assignment_result))
  end

  test "should show assignment_result" do
    get :show, id: @assignment_result
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @assignment_result
    assert_response :success
  end

  test "should update assignment_result" do
    patch :update, id: @assignment_result, assignment_result: { assignment_id: @assignment_result.assignment_id, enrollment_id: @assignment_result.enrollment_id, pass: @assignment_result.pass }
    assert_redirected_to assignment_result_path(assigns(:assignment_result))
  end

  test "should destroy assignment_result" do
    assert_difference('AssignmentResult.count', -1) do
      delete :destroy, id: @assignment_result
    end

    assert_redirected_to assignment_results_path
  end
end
