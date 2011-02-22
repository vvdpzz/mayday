require 'test_helper'

class BrainstormsControllerTest < ActionController::TestCase
  setup do
    @brainstorm = brainstorms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:brainstorms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create brainstorm" do
    assert_difference('Brainstorm.count') do
      post :create, :brainstorm => @brainstorm.attributes
    end

    assert_redirected_to brainstorm_path(assigns(:brainstorm))
  end

  test "should show brainstorm" do
    get :show, :id => @brainstorm.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @brainstorm.to_param
    assert_response :success
  end

  test "should update brainstorm" do
    put :update, :id => @brainstorm.to_param, :brainstorm => @brainstorm.attributes
    assert_redirected_to brainstorm_path(assigns(:brainstorm))
  end

  test "should destroy brainstorm" do
    assert_difference('Brainstorm.count', -1) do
      delete :destroy, :id => @brainstorm.to_param
    end

    assert_redirected_to brainstorms_path
  end
end
