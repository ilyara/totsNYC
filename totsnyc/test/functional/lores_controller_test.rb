require 'test_helper'

class LoresControllerTest < ActionController::TestCase
  setup do
    @lore = lores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lore" do
    assert_difference('Lore.count') do
      post :create, :lore => @lore.attributes
    end

    assert_redirected_to lore_path(assigns(:lore))
  end

  test "should show lore" do
    get :show, :id => @lore.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @lore.to_param
    assert_response :success
  end

  test "should update lore" do
    put :update, :id => @lore.to_param, :lore => @lore.attributes
    assert_redirected_to lore_path(assigns(:lore))
  end

  test "should destroy lore" do
    assert_difference('Lore.count', -1) do
      delete :destroy, :id => @lore.to_param
    end

    assert_redirected_to lores_path
  end
end
