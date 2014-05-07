require 'test_helper'

class SolversControllerTest < ActionController::TestCase
  setup do
    @solver = solvers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:solvers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create solver" do
    assert_difference('Solver.count') do
      post :create, solver: {  }
    end

    assert_redirected_to solver_path(assigns(:solver))
  end

  test "should show solver" do
    get :show, id: @solver
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @solver
    assert_response :success
  end

  test "should update solver" do
    patch :update, id: @solver, solver: {  }
    assert_redirected_to solver_path(assigns(:solver))
  end

  test "should destroy solver" do
    assert_difference('Solver.count', -1) do
      delete :destroy, id: @solver
    end

    assert_redirected_to solvers_path
  end
end
