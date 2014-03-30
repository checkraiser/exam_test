require 'test_helper'

class AssignmentConfigsControllerTest < ActionController::TestCase
  setup do
    @course = courses(:one)
    @assignment = @course.assignments.create!(title: 'title1', content: 'content1', description: 'desc1')
    @assignment_config = @assignment.assignment_configs.create!(input: 'abc', output: 'def')
    @user = User.first
    sign_in @user
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stubs(:current_ability).returns(@ability)
  end

  test "should get index" do
    get :index, course_id: @course.id, assignment_id: @assignment.id
    assert_response :success
    assert_not_nil assigns(:assignment_configs)
  end

  test "should get new" do
    get :new, course_id: @course.id, assignment_id: @assignment.id
    assert_response :success
  end

  test "should create assignment_config" do
    @ability.can :manage, @course
    assert_difference('AssignmentConfig.count') do
      post :create, course_id: @course.id, assignment_id: @assignment.id, assignment_config: {input: @assignment_config.input, output: @assignment_config.output }
    end

    assert_redirected_to assignment_config_path(assigns(:assignment_config))
  end

  test "should show assignment_config" do
    get :show, course_id: @course.id, assignment_id: @assignment.id, id: @assignment_config
    assert_response :success
  end

  test "should get edit" do
    @ability.can :manage, @course
    get :edit, course_id: @course.id, assignment_id: @assignment.id, id: @assignment_config
    assert_response :success
  end

  test "should update assignment_config" do
    @ability.can :manage, @course
    patch :update, course_id: @course.id, assignment_id: @assignment.id, id: @assignment_config, assignment_config: { input: @assignment_config.input, output: @assignment_config.output }
    assert_redirected_to assignment_config_path(assigns(:assignment_config))
  end

  test "should destroy assignment_config" do
    @ability.can :manage, @course
    assert_difference('AssignmentConfig.count', -1) do
      delete :destroy, id: @assignment_config, course_id: @course.id, assignment_id: @assignment.id, id: @assignment_config
    end

    assert_redirected_to assignment_configs_path
  end
end
