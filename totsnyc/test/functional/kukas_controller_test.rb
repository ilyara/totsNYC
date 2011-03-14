require 'test_helper'

class KukasControllerTest < ActionController::TestCase
  setup do
    @kuka = kukas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kukas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kuka" do
    assert_difference('Kuka.count') do
      post :create, :kuka => @kuka.attributes
    end

    assert_redirected_to kuka_path(assigns(:kuka))
  end

  test "should show kuka" do
    get :show, :id => @kuka.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @kuka.to_param
    assert_response :success
  end

  test "should update kuka" do
    put :update, :id => @kuka.to_param, :kuka => @kuka.attributes
    assert_redirected_to kuka_path(assigns(:kuka))
  end

  test "should destroy kuka" do
    assert_difference('Kuka.count', -1) do
      delete :destroy, :id => @kuka.to_param
    end

    assert_redirected_to kukas_path
  end
end
